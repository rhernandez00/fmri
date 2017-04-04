function getCoords(fileName,varargin)

    mask = false;%getArgumentValue('mask',false,varargin{:},'warningoff');
    operation = 'max';%getArgumentValue('operation','max',varargin{:},'warningoff');

    data = load_untouch_nii(fileName);
    if mask
        maskData = load_untouch_nii(mask);
        data.img(:) = data.img(:).* (maskData.img(:) ~= 0); 
    end


switch operation
    case 'max'
        [val,coords] = Max3d(data.img);
        data.img(coords(1),coords(2),coords(3)) = 0;   
        ['Coordinates: ',num2str(coords), ' value: ', num2str(val)]
        [val2,coords2] = Max3d(data.img);

        while val == val2
            [val,coords] = Max3d(data.img);
            ['Coordinates: ',num2str(coords), ' value: ', num2str(val)]
            data.img(coords(1),coords(2),coords(3)) = 0;   
            [val2,coords2] = Max3d(data.img);

        end
    otherwise
end