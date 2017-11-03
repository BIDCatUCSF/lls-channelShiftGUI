function pushFilecallback(button,~,guiCS,handles)
%pushFilecallback Prompts the user to find the file. R2015b
%
% Kyle Marchuk, PhD
% Biological Imaging Development Center at UCSF
% June 2017

    %% Prompt the user to select a file
    structParameters = getappdata(guiCS,'structParameters');
    buttonTag = str2num(get(button,'Tag'));
    % Name the button tag as the structure field
    inputFile = structParameters.fileNames{buttonTag};
    % Check for a currently selected file
    if ~isempty(inputFile)
        [fileSelection,pathSelection] = uigetfile({'*.tif'},'Select .tif',structParameters.pathDir);
    else
        [fileSelection,pathSelection] = uigetfile({'*.tif'},'Select .tif');
    end % if
    
    %% Check for a canceled selection.
    if fileSelection(1) == 0 || strcmp(fileSelection,inputFile)
        return
    end % if
    % Assign new file name to the structure
    structParameters.pathDir = pathSelection;
    structParameters.fileNames{buttonTag} = fileSelection;
    setappdata(guiCS,'structParameters',structParameters);
    % Display the name in the text field
    buttonTagZ = num2str(buttonTag)-1;
    displayName = strcat('displaych',buttonTagZ,'Name');
    handles.(displayName).String = structParameters.fileNames{buttonTag};

end % pushFilecallback

