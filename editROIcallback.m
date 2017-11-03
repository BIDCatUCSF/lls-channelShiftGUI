function editROIcallback(hObject,~,hObjectContainer,guiCS)
%editROIcallback Updates the ROI to be displayed. R2015b
%
% Kyle Marchuk, PhD
% Biological Imaging Development Center at UCSF
% June 2017
    %% Get the parameters struct
    structParameters = getappdata(guiCS,'structParameters');
    
    %% Get the tag and converted string for the calling editbox
    hObjectTag = get(hObject,'Tag');   
    newValue = str2double(get(hObject,'String'));
    
    % Check to see whether new value is a number and integer
    if isnan(newValue) || newValue <= 0
        set(hObject, 'String', hObjectContainer.OldString)
    elseif ~mod(newValue,1) == 0
        set(hObject, 'String', hObjectContainer.OldString)
    else
        switch hObjectTag
            case 'editXmin'
                % xMin needs to be less than xMax
                if newValue >= structParameters.xMax
                    set(hObject,'String',hObjectContainer.OldString)
                else
                    % Update control property
                    hObjectContainer.OldString = newValue;
            
                    % Update the appdata
                    structParameters.xMin = newValue;
                    setappdata(guiCS, 'structParameters',structParameters)
                end % if
            case 'editXmax'
                % xMax needs to be greater than xMin
                if newValue <= structParameters.xMin
                    set(hObject,'String',hObjectContainer.OldString)
                else
                    % Update control property
                    hObjectContainer.OldString = newValue;
                    
                    % Update the appdata
                    structParameters.xMax = newValue;
                    setappdata(guiCS,'structParameters',structParameters)
                end %if
            case 'editYmin'
                % yMin needs to be less than yMax
                if newValue >= structParameters.yMax
                    set(hObject,'String',hObjectContainer.OldString)
                else
                    % Update control property
                    hObjectContainer.OldString = newValue;
            
                    % Update the appdata
                    structParameters.yMin = newValue;
                    setappdata(guiCS, 'structParameters',structParameters)
                end % if
            case 'editYmax'
                % yMax needs to be greater than yMin
                if newValue <= structParameters.yMin
                    set(hObject,'String',hObjectContainer.OldString)
                else
                    % Update control property
                    hObjectContainer.OldString = newValue;
            
                    % Update the appdata
                    structParameters.yMax = newValue;
                    setappdata(guiCS, 'structParameters',structParameters)
                end % if
            case 'editZmin'
                % zMin needs to be less than zMax
                if newValue >= structParameters.zMax
                    set(hObject,'String',hObjectContainer.OldString)
                else
                    % Update control property
                    hObjectContainer.OldString = newValue;
            
                    % Update the appdata
                    structParameters.zMin = newValue;
                    setappdata(guiCS, 'structParameters',structParameters)
                end % if
            case 'editZmax'
                % zMin needs to be greater than zMax
                if newValue <= structParameters.zMin
                    set(hObject,'String',hObjectContainer.OldString)
                else
                    % Update control property
                    hObjectContainer.OldString = newValue;
            
                    % Update the appdata
                    structParameters.zMax = newValue;
                    setappdata(guiCS, 'structParameters',structParameters)
                end % if
        end %switch
    end % if
    
    % Call the function to shift the display
    updatePreview(guiCS);
end %editROIcallback

