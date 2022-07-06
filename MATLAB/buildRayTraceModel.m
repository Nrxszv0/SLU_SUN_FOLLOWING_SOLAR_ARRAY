%%% Defines the 3D shape in body (unrotated) coordinates
% faces -- Length and width of each flat plane (x-dim, y-dim, 0)
% faceColors -- color to use for each plate (Matlab plot syntax: 'rx' or 'b.', etc
% centerPoint -- location of the geometric center of each face, body coordinates
% baseFaceTransform -- direction cosine matrix to orient faces in body coordinates
% 
function [faces, faceColors, numFaces, centerPoint, baseFaceTransform] = ...
    buildRayTraceModel()
x0 = 10;
y0 = 30;
% Dimensions of the X & Y faces in their flat-plane configuration
faces = [
    x0 x0 0; %Front Face 
    x0 y0 0; %Bottom Face
    x0 y0 0; %Top of Top Face
    y0 y0 0; %Bottom of Top Face
    x0 y0 0; %Right Face
    x0 y0 0; %Left Face
    x0 x0 0; %Back Face
    x0 y0 0;
    x0 y0 0;
    x0 y0 0;
    x0 y0 0]; 
faceColors = ['b', 'g', 'r', 'c', 'm', 'y', 'k', 'b', 'b', 'g', 'g'];
% Locate the center of each face in body coordinates
centerPoint = 0.5*[
    0 -y0 0;  %Front Face 
    0  0 x0;  %Bottom Face
    0  0 -x0; %Top of Top Face
    0  0 -x0; %Bottom of Top Face
    x0 0  0;  %Right Face
    -x0 0 0;  %Left Face
    0  y0 0; %Back Face
    2*x0 0 -2*x0;
    2*x0 0 2*x0;
    -2*x0 0 2*x0;
    -2*x0 0 -2*x0]; 
% Identify the rotation to put the face into body coordinates
baseFaceTransform(:, :, 1) = [1 0 0; 0 0 -1; 0 1 0]; %Front
baseFaceTransform(:, :, 2) = eye(3); %Bottom
%baseFaceTransform(:, :, 3) = eye(3); %Top of Top
baseFaceTransform(:, :, 3) = [1 0 0; 0 1 0; 0 0 1]; %Top of Top
baseFaceTransform(:, :, 4) = [-1 0 0 ; 0 1 0; 0 0 -1]; %Bottom of Top
baseFaceTransform(:, :, 5) = [0 0 1; 0 1 0; 1 0 0]; %Right
baseFaceTransform(:, :, 6) = [0 0 -1; 0 1 0; -1 0 0]; %Left
baseFaceTransform(:, :, 7) = [-1 0 0; 0 0 1; 0 1 0]; %Back
baseFaceTransform(:, :, 8) = [-sqrt(2)/2 0 1;  0 1 0; 1 0 0]; %Top Right
baseFaceTransform(:, :, 9) = [sqrt(2)/2 0 1;  0 1 0; 1 0 0]; %Bottom Right
baseFaceTransform(:, :, 10) = [-sqrt(2)/2 0 1;  0 1 0; 1 0 0]; %Bottom Left
baseFaceTransform(:, :, 11) = [sqrt(2)/2 0 1;  0 1 0; 1 0 0]; %Top Left
numFaces = size(faces, 1);
