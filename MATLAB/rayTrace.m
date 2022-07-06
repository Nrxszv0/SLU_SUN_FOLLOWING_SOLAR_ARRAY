% Ray tracing. We draw the polygons and then step through the grid to
% figure out which of them are visible
% MAS 30 June 2022
clear
doPixelPlots = 0;
gridSpacing = 0.5;
% This is a 3-1 Euler rotation; we don't need a third rotation because we
% are computing area exposed to the Sun, so we are independent of the roll
% axis around the Sun line
theta_deg = 40;    % degrees. This is the rotation about the z-axis (yaw)
phi_deg = 40;  % degrees. This is the rotation about the body x-axis (pitch)

%% Build the plane in the body coordinates
[faces, faceColors, numFaces, centerPoint, baseFaceTransform] = ...
    buildRayTraceModel();

% This is a flat plate lying in the XY plane
figure(1), clf, axis(20*[-1 1 -1 1]), axis equal, grid on, hold on
bodyHandle = subplot(1,1,1);
title('Unrotated body'), xlabel('Body X-axis'), ylabel('Body Y-axis')
figure(2), clf, axis(20*[-1 1 -1 1]), axis equal, grid on, hold on
handleRotate = subplot(1,1,1);
title(sprintf('Rotated body (theta=%4.1f°, phi=%4.1f°)', theta_deg, phi_deg)), xlabel('Global X-axis'), ylabel('Global Y-axis')

% Prepare the transformations
[corners_in_global, facenorm_in_global, centerPoint_in_global, intercepts] ...
    = doRaytraceRotations(theta_deg*pi/180, phi_deg*pi/180, centerPoint, ...
    baseFaceTransform, faces, faceColors, numFaces, handleRotate, bodyHandle);

[ray, smallestDot] = doVertexCalculations(numFaces, corners_in_global);

if (doPixelPlots)
    doPixelPlots = handleRotate;
end

% Run through all the pixels
pixelCount = zeros(numFaces, 1);
for i=-20:gridSpacing:20
    for j=-20:gridSpacing:20
        thisPoint = [i j]';
        pixelCount = findPixelIntercept(thisPoint, numFaces, facenorm_in_global, ...
            corners_in_global, ray, smallestDot, intercepts, pixelCount, ...
            faceColors, doPixelPlots);
    end
end

fprintf('For rotated body (theta=%4.1f°, phi=%4.1f°, %5.3f units/pixel\n', ...
    theta_deg, phi_deg, gridSpacing^2)
for i=1:numFaces
    fprintf('Face %i\t%i pixels (%5.2f area units)\n', i, pixelCount(i), pixelCount(i)*gridSpacing*gridSpacing)
end