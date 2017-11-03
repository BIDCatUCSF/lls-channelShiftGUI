function editOffsetcallback(hObject,~,hObjectContainer,guiCS)
%editOffsetcallback Shifts the display of the channel overlay. R2015b
%
% Kyle Marchuk, PhD
% Biological Imaging Development Center at UCSF
% June 2017

    %% Get the parameters struct
    structOffset = getappdata(guiCS,'structOffset');
    
    %% Get the tag and converted string for the calling editbox
    hObjectTag = get(hObject,'Tag');   
    newValue = str2double(get(hObject,'String'));
    
    % Check to see whether new value is a number and integer
    if isnan(newValue)
        set(hObject, 'String', hObjectContainer.OldString)
    elseif ~mod(newValue,1) == 0
        set(hObject, 'String', hObjectContainer.OldString)
    else
        switch hObjectTag
            % ch1
            case 'editXoff1'
                hObjectContainer.OldString = newValue;         
                structOffset.ch1.x = newValue;
                setappdata(guiCS,'structOffset',structOffset);
                
            case 'editYoff1'
                hObjectContainer.OldString = newValue;         
                structOffset.ch1.y = newValue;
                setappdata(guiCS,'structOffset',structOffset);
                
            case 'editZoff1'
                hObjectContainer.OldString = newValue;         
                structOffset.ch1.z = newValue;
                setappdata(guiCS,'structOffset',structOffset);
            % ch2    
            case 'editXoff2'
                hObjectContainer.OldString = newValue;         
                structOffset.ch2.x = newValue;
                setappdata(guiCS,'structOffset',structOffset);
                
            case 'editYoff2'
                hObjectContainer.OldString = newValue;         
                structOffset.ch2.y = newValue;
                setappdata(guiCS,'structOffset',structOffset);
                
            case 'editZoff2'
                hObjectContainer.OldString = newValue;         
                structOffset.ch2.z = newValue;
                setappdata(guiCS,'structOffset',structOffset);
            % ch3    
            case 'editXoff3'
                hObjectContainer.OldString = newValue;         
                structOffset.ch3.x = newValue;
                setappdata(guiCS,'structOffset',structOffset);
                
            case 'editYoff3'
                hObjectContainer.OldString = newValue;         
                structOffset.ch3.y = newValue;
                setappdata(guiCS,'structOffset',structOffset);
                
            case 'editZoff3'
                hObjectContainer.OldString = newValue;         
                structOffset.ch3.z = newValue;
                setappdata(guiCS,'structOffset',structOffset);
            % ch4    
            case 'editXoff4'
                hObjectContainer.OldString = newValue;         
                structOffset.ch4.x = newValue;
                setappdata(guiCS,'structOffset',structOffset);
                
            case 'editYoff4'
                hObjectContainer.OldString = newValue;         
                structOffset.ch4.y = newValue;
                setappdata(guiCS,'structOffset',structOffset);
                
            case 'editZoff4'
                hObjectContainer.OldString = newValue;         
                structOffset.ch4.z = newValue;
                setappdata(guiCS,'structOffset',structOffset);
            % ch5    
            case 'editXoff5'
                hObjectContainer.OldString = newValue;         
                structOffset.ch5.x = newValue;
                setappdata(guiCS,'structOffset',structOffset);
                
            case 'editYoff5'
                hObjectContainer.OldString = newValue;         
                structOffset.ch5.y = newValue;
                setappdata(guiCS,'structOffset',structOffset);
                
            case 'editZoff5'
                hObjectContainer.OldString = newValue;         
                structOffset.ch5.z = newValue;
                setappdata(guiCS,'structOffset',structOffset);
        end % switch
    end % if
    
    % Call the function to shift the display
    updatePreview(guiCS);
end % editOffsetcallback

