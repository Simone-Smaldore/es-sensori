% READ, CROP AND SAVE SCAN DATA AND AXES

% pixel coordinates: Top-Left ; Bottom-Right
TL = [0 256]; 
BR = [655 0];

% load data
h_wait = waitbar(0,'Please wait...');
for i=1:length(filelist)
    % load data
    I = imread(filelist{i});
    % convert to grayscale
    %I_gray = rgb2gray(I(TL(1):TL(2),BR(2):BR(1),:));
    
    % store data to a 3D matrix (memorizzare i dati in una matrice 3D)
    M(:,:,i)=I;
%     M(:,:,i)=I_gray;% vecchia
    waitbar(i/length(filelist))
end
close(h_wait);

% axes (mm)
% electronic scan lateral direction
X=(((0:size(M,2)-1)'*phys_pitch)/repr_pitch)*pixel_length;
% mechanical scan lateral direction
Y=(0:size(M,3)-1)'*stepsize;
% axial direction
Z=(0:size(M,1)-1)'*pixel_length;




