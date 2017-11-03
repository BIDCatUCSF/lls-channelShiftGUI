function buttonCallback(buttonGroup, ~, guiCS)
%buttonCallback Updates the preview based on the channel selection with the
%radio buttons
% 
% Kyle Marchuk, PhD
% Biological Imaging Development Center at UCSF
% June 2017

    %%
    structParameters = getappdata(guiCS,'structParameters');
    buttonID = get(get(buttonGroup,'SelectedObject'),'Tag');
    switch buttonID
        case 'ch1'
            if isempty(structParameters.fileNames{2}) == 0
                structParameters.cc = 2;
                disp('Channel 1');
            else
                disp('Choose another channel. Channel is Empty.');
                return
            end % if
        case 'ch2'
            if isempty(structParameters.fileNames{3}) == 0
                structParameters.cc = 3;
                disp('Channel 2');
            else
                disp('Choose another channel. Channel is Empty.');
                return
            end % if
        case 'ch3'
            if isempty(structParameters.fileNames{4}) == 0
                structParameters.cc = 4;
                disp('Channel 3');
            else
                disp('Choose another channel. Channel is Empty.');
                return
            end % if
        case 'ch4'
            if isempty(structParameters.fileNames{5}) == 0
                structParameters.cc = 5;
                disp('Channel 4');
            else
                disp('Choose another channel. Channel is Empty.');
                return
            end % if
        case 'ch5'
            if isempty(structParameters.fileNames{6}) == 0
                structParameters.cc = 6;
                disp('Channel 5');
            else
                disp('Choose another channel. Channel is Empty.');
                return
            end % if
    end % switch
    setappdata(guiCS,'structParameters',structParameters);
    updatePreview(guiCS);


end %buttonCallback

