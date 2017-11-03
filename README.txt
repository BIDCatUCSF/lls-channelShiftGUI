Requirements:
Matlab 2015b or later
Image Analysis Toolbox

Open ChannelShiftGUI.m and Run

To use:
Select decon .tif files (from within the same folder) for each channel - preferably of the same timepoint. When all channel files have been selected (not all 6 channels need to be filled), press "Load".

The program will make 3D MIPs of the selected .tifs and display a 2-color overlay based on which channel is selected compared to ch0. All offsets are compared to ch0.

The sliders will adjust "Brightness" for each channel.

The "Display ROI" box changes the range that is displayed for each dimension allowing the user to focus on specific beads or features. Please note: This does not recalculate the MIP. It only acts as a "Zoom" funtion.

Channel offsets allows the user to shift channels in relation to ch0 by 1 pixel increments. 

Crop ROI will then crop the entire directory taking into account the channel offsets to overlay the data (and saving as 16-bit within the parent directory). Please note: The user must be smart about this and allow padding to not run into index out of bounds errors. For example; if a user is shifting 2 pixels in Z and the file is 150 stacks, the final size of the cropped images can only be 148 stacks. The program does not currently pad with zeros.

Email: kyle.marchuk@ucsf.edu 