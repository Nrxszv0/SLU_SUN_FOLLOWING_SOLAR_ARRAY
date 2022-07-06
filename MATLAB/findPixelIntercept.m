%%% Calculate whether the (x,y) pixel in global coordinates intersects each
%%% face, and determine which face is on top
%
% pixelCount -- array that counts the number of pixels visible on each face
% thisPixel -- [x y] coordinates of the pixel
% facenorm_in_global -- array of the norms of each face in global coords
% corners_in_global -- array of the location of each corner of each face
% ray -- array of the rays from each corner to the other corners on the same face, global coordinates
% smallestDot -- array of the magnitude of the smallest dot product for each corner
% intercepts -- array of the solution to (norm).[x y z]' = intercepts
% doPlot -- pass 0 if no plots, pass the plotHandle if you want to plot

%% TODO: You probably only need to calculate the rays for two opposing vertices

function pixelCount = findPixelIntercept(thisPixel, numFaces, facenorm_in_global, ...
    corners_in_global, ray, smallestDot, intercepts, pixelCount, faceColors, doPlot)

% Set defaults
thisHeight = -1e6;
thisFace = -1;
% Step through each face, determine whether the pixel intercepts that face
% and then identify whether this face is in front of any other faces
for i=1:numFaces
    % If the face is down, it cannot see the ray. So we skip
    if (facenorm_in_global(3, i) > 0)
        kCount = 0;
        % Repeat for each corner of this face: determine whether the pixel
        % is between the edges that eminate from this corner
        % TODO: Does this really need to be 4, or can you pick 2 opposing
        % faces?
        for k=1:4
            thisRay = thisPixel - corners_in_global(1:2, k, i);
            thisRay = thisRay / norm(thisRay);
            % If it's between the edges, it must have the largest dot
            % product
            if (thisRay'*ray(:, 1, k, i) >= smallestDot(k, i))
                if (thisRay'*ray(:, 2, k, i) >= smallestDot(k, i))
                    kCount = kCount+1;
                end
            end
        end
        % If all four were satisfied, then it's in the box. Now the
        % question is: which one is on top. We know that the equation
        % for this face in global coordinates is:
        %        norm . S = intercept,
        % where norm is the normal vector and
        % intercept is the constant calculated above.
        % Since we know the X, Y coordinates, we can calculate the
        % height Z:
        %       Z = (intercept - n_x*X0 - n_y*Y0)/n_z
        if (kCount == 4)
            newHeight = (intercepts(i) ...
                - facenorm_in_global(1, i)*thisPixel(1) ...
                - facenorm_in_global(2, i)*thisPixel(2)) ...
                / facenorm_in_global(3, i);
            if (newHeight) > thisHeight
                thisHeight = newHeight;
                thisFace = i;
            end
        end
    end
end
if (thisFace > 0)
    pixelCount(thisFace) = pixelCount(thisFace) + 1;
    if (doPlot ~= 0)
        plot(doPlot, thisPixel(1), thisPixel(2), sprintf('%s.', faceColors(thisFace)))
    end
end