%%% Calculate the edge vectors between vertexes in global coordinates,
%%% including the angle between the vertexes (smallestDot)
%
% ray -- array of vectors from one vertex to the others on the same face in global coordinates.
% smallestDot -- smallest-magnitude dot product between the rays for each corner
%
% corners_in_global -- location of the corners (vertexes) of each face in global coordinates
function [ray, smallestDot] = doVertexCalculations(numFaces, corners_in_global)

% Build the array of vertices
rayTest = zeros(2, 3);
ray = zeros(2, 2, 4, numFaces);
smallestDot = zeros(4, numFaces);

for face_i=1:numFaces
    for i=1:4
        basePoint = i;
        lineCount = 1;
        for j=1:4
            if (j ~= basePoint)
                rayTest(1:2, lineCount) = corners_in_global(1:2,j, face_i) ...
                    - corners_in_global(1:2,i, face_i);
                rayTest(1:2, lineCount) = rayTest(:, lineCount) ...
                    / norm(rayTest(:, lineCount));
                lineCount = lineCount+1;
            end
        end
        combos = [1 2; 1 3; 2 3];
        smallestDot(i, face_i) = 10;
        for j=1:3
            thisDot = rayTest(:, combos(j, 1))'*rayTest(:, combos(j, 2));
            if (thisDot < smallestDot(i, face_i))
                smallestDot(i, face_i) = thisDot;
                ray(:, :, i, face_i) = rayTest(:, combos(j, :));
            end
        end
    end
end
