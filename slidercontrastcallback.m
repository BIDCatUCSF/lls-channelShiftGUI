function slidercontrastcallback(slider,~,guiCS)
%slidercontrastcallback Gets the slider value and updates the preview.
%R2015b
% 
% Kyle Marchuk, PhD
% Biological Imaging Development Center at UCSF
% June 2017

    %%
    % Get the structure parameters and find out which slider moved
    structParameters = getappdata(guiCS,'structParameters');
    sliderTag = get(slider,'Tag');
    % Assign the value to the appropriate slider
    switch sliderTag
        case 'sliderCh0'
            sliderValue = get(slider,'Value');
            structParameters.Ch0ContrastValue = sliderValue;
            
        case 'sliderChX'
            sliderValue = get(slider,'Value');
            structParameters.ChXContrastValue = sliderValue;
    end %switch
    
    % Turn off the axes visibility so the update does not overlay
    structParameters.axes1.Visible = 'off';
    structParameters.axes2.Visible = 'off';
    structParameters.axes3.Visible = 'off';
    setappdata(guiCS,'structParameters',structParameters);
    % call the update preview function
    updatePreview(guiCS);
    
end % slidercontrastcallback

