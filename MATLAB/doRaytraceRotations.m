%%% Takes the body-coordinate 3D model and calculatest the location of the
%%% corners and centers in global coordinates, as well as the normals and
%%% intercept needed for the flate-plate calcuation
% For now, this is a 3-1 Euler rotation from body to global
% theta -- 3-axis Euler rotation (in RADIANS)
% phi -- 1-axis Euler rotation (in RADIANS)
%
% faces -- Length and width of each flat plane (x-dim, y-dim, 0)
% faceColors -- color to use for each plate (Matlab plot syntax: 'rx' or 'b.', etc
% centerPoint -- location of the geometric center of each face, body coordinates
% baseFaceTransform -- direction cosine matrix to orient faces in body coordinates
% plotHandle -- Matlab graphics element for plotting points in rotated coordinates
% bodyHandle -- Matlab graphics element for plotting body coordinates
%
% corners_in_global -- location of the 4 corners of each face in global coordinates (clockwise ? from 0,0 )
% facenorm_in_global -- orientation of the unit normal of the plane in global coordinates
% centerPoint_in_global -- location of the center of the face in global coordinates
% intercepts -- solutions to the planar equation (norm).[x y z]' = intercepts

function [corners_in_global, facenorm_in_global, centerPoint_in_global, intercepts] ...
    = doRaytraceRotations(theta, phi, centerPoint, baseFaceTransform, faces, ...
    faceColors, numFaces, plotHandle, bodyHandle)

%% Perform the Euler rotations (3-1)
thetaMatrix = [
    cos(theta) sin(theta) 0;
    -sin(theta) cos(theta) 0;
    0 0 1]';
phiMatrix = [
    1 0 0;
    0 cos(phi) sin(phi);
    0 -sin(phi) cos(phi)]';
%% Define the arrays to speed up computation
corners_in_body = zeros(3, 4);
corner_plot_array1 = [1 1 2 3];
corner_plot_array2 = [2 4 3 4];
corners_in_global = zeros(3, 4, numFaces);
facenorm_in_global = zeros(3, numFaces);
centerPoint_in_global = zeros(3, numFaces);

% Repeat for every face
for j=1:numFaces
    % Transform the corners. Start in plane coordinates
    corners = 0.5*[
        -faces(j, 1) faces(j, 2) 0 ;
        -faces(j, 1) -faces(j, 2) 0;
        faces(j, 1) -faces(j, 2) 0;
        faces(j, 1) faces(j, 2) 0;
        ]';
    % Rotate the corners
    for i=1:4
        corners_in_body(:,i) = centerPoint(j,:)' + ...
            baseFaceTransform(:,:,j)*corners(:,i);
    end
    corners_in_global(:, :, j) = phiMatrix * thetaMatrix * corners_in_body;
    facenorm_in_global(:, j) = phiMatrix * thetaMatrix * baseFaceTransform(:,:,j) * [0 0 1]';
    centerPoint_in_global(:, j) = phiMatrix * thetaMatrix * centerPoint(j,:)';
    %% Trace the faces in body coordinates and global coordinates, but only if visible (face up)
    % Plot the perimeter of the plane
    for i=1:length(corner_plot_array2)
        plot(bodyHandle, ...
            corners_in_body(1, [corner_plot_array1(i) corner_plot_array2(i)]), ...
            corners_in_body(2, [corner_plot_array1(i) corner_plot_array2(i)]), ...
            faceColors(j))
        if ([0 0 1] * facenorm_in_global(:, j) > 0)
            plot(plotHandle, ...
                corners_in_global(1, [corner_plot_array1(i) corner_plot_array2(i)], j), ...
                corners_in_global(2, [corner_plot_array1(i) corner_plot_array2(i)], j), ...
                faceColors(j))
        end
    end
end
% The intercepts for the equation (Ax + By + Cz) = D can be calculated. We
% know that (A, B, C) = the norm to the plane and the centerpoint is a
% solution to the equation
intercepts = sum(centerPoint_in_global.*facenorm_in_global);