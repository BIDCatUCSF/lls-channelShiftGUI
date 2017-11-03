function editCropcallback(hObject,~,hObjectContainer,guiCS)
%editCropcallback Updates the ROI to be displayed. R2015b
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
            case 'editcXmin'
                % xcMin needs to be less than xcMax
                if newValue >= structParameters.xcMax
                    set(hObject,'String',hObjectContainer.OldString)
                else
                    % Update control property
                    hObjectContainer.OldString = newValue;
            
                    % Update the appdata
                    structParameters.xcMin = newValue;
                    setappdata(guiCS, 'structParameters',structParameters)
                end % if
            case 'editcXmax'
                % xcMax needs to be greater than xcMin
                if newValue <= structParameters.xcMin
                    set(hObject,'String',hObjectContainer.OldString)
                else
                    % Update control property
                    hObjectContainer.OldString = newValue;
                    
                    % Update the appdata
                    structParameters.xcMax = newValue;
                    setappdata(guiCS,'structParameters',structParameters)
                end %if
            case 'editcYmin'
                % ycMin needs to be less than ycMax
                if newValue >= structParameters.ycMax
                    set(hObject,'String',hObjectContainer.OldString)
                else
                    % Update control property
                    hObjectContainer.OldString = newValue;
            
                    % Update the appdata
                    structParameters.ycMin = newValue;
                    setappdata(guiCS, 'structParameters',structParameters)
                end % if
            case 'editcYmax'
                % ycMax needs to be greater than ycMin
                if newValue <= structParameters.ycMin
                    set(hObject,'String',hObjectContainer.OldString)
                else
                    % Update control property
                    hObjectContainer.OldString = newValue;
            
                    % Update the appdata
                    structParameters.ycMax = newValue;
                    setappdata(guiCS, 'structParameters',structParameters)
                end % if
            case 'editcZmin'
                % zcMin needs to be less than zcMax
                if newValue >= structParameters.zcMax
                    set(hObject,'String',hObjectContainer.OldString)
                else
                    % Update control property
                    hObjectContainer.OldString = newValue;
            
                    % Update the appdata
                    structParameters.zcMin = newValue;
                    setappdata(guiCS, 'structParameters',structParameters)
                end % if
            case 'editcZmax'
                % zcMin needs to be greater than zcMax
                if newValue <= structParameters.zcMin
                    set(hObject,'String',hObjectContainer.OldString)
                else
                    % Update control property
                    hObjectContainer.OldString = newValue;
            
                    % Update the appdata
                    structParameters.zcMax = newValue;
                    setappdata(guiCS, 'structParameters',structParameters)
                end % if
        end %switch
    end % if
    


end % editcalCropcallback

