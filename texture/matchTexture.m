function [ im ] = matchTexture( noise, texture, numLevelsPyr, iterations )

im = matchHistogram(noise, texture);
analysis_pyr = genPyr( texture, 'lap',  numLevelsPyr );
%analysis_pyr = simpleTexturePyramid(texture, numLevelsPyr);

for i = 1:iterations
    
    synthesis_pyr = genPyr(im, 'lap',  numLevelsPyr );
   
    for j = 1:numLevelsPyr
        synthesis_pyr{j} = matchHistogram(synthesis_pyr{j}, analysis_pyr{j});
    end
    
    im = collapsePyramid(synthesis_pyr);
    im = matchHistogram(im, texture);
end

imagesc(im);
end

