clear all
close all
clc

stData.folder = ['MC_2'];
stData.subfolder = [stData.folder filesep 'TOSHOW' filesep];

mkdir(stData.subfolder);

imTrue = imread([stData.folder filesep 'imTrue.png']);

imTrue_L    = logical(imTrue);
imTrue_R_Py = impyramid(imTrue_L, 'reduce');

imTrue_R_Near_F = imresize(imTrue_L, 0.5, 'nearest', 'Antialiasing', false);
imTrue_R_Near_T = imresize(imTrue_L, 0.5, 'nearest', 'Antialiasing', true);

imTrue_R_BiL_F = imresize(imTrue_L, 0.5, 'bilinear', 'Antialiasing', false);
imTrue_R_BiL_T = imresize(imTrue_L, 0.5, 'bilinear', 'Antialiasing', true);

imTrue_R_BiC_F = imresize(imTrue_L, 0.5, 'bicubic', 'Antialiasing', false);
imTrue_R_BiC_T = imresize(imTrue_L, 0.5, 'bicubic', 'Antialiasing', true);

imTrue_R_Box_F = imresize(imTrue_L, 0.5, 'box', 'Antialiasing', false);
imTrue_R_Box_T = imresize(imTrue_L, 0.5, 'box', 'Antialiasing', true);

imTrue_R_La2_F = imresize(imTrue_L, 0.5, 'lanczos2', 'Antialiasing', false);
imTrue_R_La2_T = imresize(imTrue_L, 0.5, 'lanczos2', 'Antialiasing', true);

imTrue_R_La3_F = imresize(imTrue_L, 0.5, 'lanczos2', 'Antialiasing', false);
imTrue_R_La3_T = imresize(imTrue_L, 0.5, 'lanczos3', 'Antialiasing', true);

vIM = who('im*');
for idx = 1:numel(vIM)
    eval(['tempIM = ' vIM{idx} ';']);
    imwrite(tempIM,[stData.folder filesep vIM{idx} '.png']);
    figure;
    imshow(tempIM)
    set(gcf,'units','normalized','outerposition',[0 0 1 1]);
    saveas(gcf,[stData.folder filesep 'FIGURE_IM' vIM{idx} '.png'])

    if(strcmp(vIM{idx}(end),'T'))
        figure;
        set(gcf,'units','normalized','outerposition',[0 0 1 1]);

        subplot(1,3,1);
        imshow(imTrue_L)
        xlabel(['Image True (200 x 200)'],'FontSize', 6);

        subplot(1,3,2);
        imshow(tempIM)
        xlabel(['image  with antialiasing' vIM{idx}],'FontSize', 6);

        eval(['tempIM = ' vIM{idx}(1:end-1) 'F' ';']);
        subplot(1,3,3);
        imshow(tempIM)
        xlabel(['image  without antialiasing' vIM{idx}(1:end-1) 'F'], ...
                'FontSize', 6);
                
        saveas(gcf,[stData.subfolder 'FIGURE_JOINT_ITrue ANd scaled '...
                    vIM{idx}(1:end-2) '.png'])

    end
end

imF = [ zeros(100,100), ...
        imTrue_R_Near_F, imTrue_R_BiL_F , imTrue_R_BiC_F,...
        imTrue_R_Box_F , imTrue_R_La2_F, imTrue_R_La3_F];
     
imT = [ imTrue_R_Py, ...
        imTrue_R_Near_T, imTrue_R_BiL_T , imTrue_R_BiC_T,...
        imTrue_R_Box_T , imTrue_R_La2_T, imTrue_R_La3_T];
             
imshow([imTrue_L, [imF ; imT]])
title(['Images and Resizing' stData.folder])
xlabel(['Left Image (200x200) : Im True ; ' '(DOWN) From Left to Right : ' ...
        ' Pyramid , Nearest, Bilineal, Bicubic, Box, lanczos2, lanczos3'] , ...
        'FontSize', 6);
%set(gcf,'units','normalized','outerposition',[0 0 1 1]);
saveas(gcf,[stData.folder filesep 'Analysis_Images.png'])
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Spectrum Analysis
imF_DCT = [ zeros(100,100), ...
        dct2(imTrue_R_Near_F), dct2(imTrue_R_BiL_F) , dct2(imTrue_R_BiC_F),...
        dct2(imTrue_R_Box_F) , dct2(imTrue_R_La2_F), dct2(imTrue_R_La3_F)];
     
imT_DCT = [ dct2(imTrue_R_Py), ...
        dct2(imTrue_R_Near_T) ,dct2(imTrue_R_BiL_T) , dct2(imTrue_R_BiC_T),...
        dct2(imTrue_R_Box_T) , dct2(imTrue_R_La2_T), dct2(imTrue_R_La3_T)];

figure;
imshow([dct2(imTrue_L), [imF_DCT ; imT_DCT]])   
title(['DCT for Images and Resizing (Gray)' stData.folder])
xlabel(['Left Image (200x200) : DCT(Im True) ; ' '(DOWN) From Left to Right : ' ...
        ' Pyramid , Nearest, Bilineal, Bicubic, Box, lanczos2, lanczos3'] , ...
        'FontSize', 6);
%set(gcf,'units','normalized','outerposition',[0 0 1 1]);
saveas(gcf,[stData.folder filesep 'Analysis_DCT_Gray.png'])

figure;
imshow([dct2(imTrue_L), [imF_DCT ; imT_DCT]]); colormap('jet')
title(['DCT for Images and Resizing (JET colormap)' stData.folder])
xlabel(['Left Image (200x200) : DCT(Im True) ; ' '(DOWN) From Left to Right : ' ...
        ' Pyramid , Nearest, Bilineal, Bicubic, Box, lanczos2, lanczos3 '] , ...
        'FontSize', 6);
saveas(gcf,[stData.folder filesep 'Analysis_DCT_Jet.png'])



figure;
thresholdB = 0.3;
imshow([dct2(imTrue_L).* (abs(dct2(imTrue_L))>thresholdB), ... 
       [imF_DCT .* (abs(imF_DCT) >thresholdB) ; imT_DCT .* (abs(imT_DCT)>thresholdB)]])
colormap('jet')
title(['DCT for Images and Resizing (JET colormap)' stData.folder])
xlabel(['Left Image (200x200) : DCT(Im True) ; ' '(DOWN) From Left to Right : ' ...
        ' Pyramid , Nearest, Bilineal, Bicubic, Box, lanczos2, lanczos3 '] , ...
        'FontSize', 6);
saveas(gcf,[stData.folder filesep 'Analysis_THRESHOLD_DCT_Jet.png'])




close all
figure;
thresholdB = 0.3;
title(['DCT Coefficients for Images and Resizing' stData.folder])
xlabel(['Left Image (200x200) : DCT Coeffs(Im True) ; ' '(DOWN) From Left to Right : ' ...
        ' Pyramid , Nearest, Bilineal, Bicubic, Box, lanczos2, lanczos3 '] , ...
        'FontSize', 6);

subplot(2,9,[1 2 10 11])
plot(reshape(abs(dct2(imTrue_L)),1,[]))
xlim([1 500]);

subplot(2,9,4)
plot(reshape(abs(dct2(imTrue_R_Near_F)),1,[]))
xlim([1 500]);

subplot(2,9,5)
plot(reshape(abs(dct2(imTrue_R_BiL_F)),1,[]))
xlim([1 500]);

subplot(2,9,6)
plot(reshape(abs(dct2(imTrue_R_BiC_F)),1,[]))
xlim([1 500]);
subplot(2,9,7)
plot(reshape(abs(dct2(imTrue_R_Box_F)),1,[]))
xlim([1 500]);
subplot(2,9,8)
plot(reshape(abs(dct2(imTrue_R_La2_F)),1,[]))
xlim([1 500]);
subplot(2,9,9)
plot(reshape(abs(dct2(imTrue_R_La3_F)),1,[]))
xlim([1 500]);


subplot(2,9,12)
plot(reshape(abs(dct2(imTrue_R_Py)),1,[]))
xlim([1 500]);
subplot(2,9,13)
plot(reshape(abs(dct2(imTrue_R_Near_T)),1,[]))
xlim([1 500]);
subplot(2,9,14)
plot(reshape(abs(dct2(imTrue_R_BiL_T)),1,[]))
xlim([1 500]);
subplot(2,9,15)
plot(reshape(abs(dct2(imTrue_R_BiC_T)),1,[]))
xlim([1 500]);
subplot(2,9,16)
plot(reshape(abs(dct2(imTrue_R_Box_T)),1,[]))
xlim([1 500]);
subplot(2,9,17)
plot(reshape(abs(dct2(imTrue_R_La2_T)),1,[]))
xlim([1 500]);
subplot(2,9,18)
plot(reshape(abs(dct2(imTrue_R_La3_T)),1,[]))
xlim([1 500]);

saveas(gcf,[stData.folder filesep 'Analysis_Coeffs_THRESHOLD_DCT.png'])




