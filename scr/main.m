close all;
clear all;
clc;

img_rgb = imread('/Users/lijiayuan/Downloads/Nocturne_Opus_9_No._1__in_B_Minor.png');
img_gray = rgb2gray(img_rgb);
[pic_length, pic_width] = size(img_gray);
% imshow(img_gray);
% imhist(img);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                     %
%    Segmentation and Preprocessing   %
%                                     %                            
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 1. Binarization 
T1 = graythresh(img_gray);
img_gray_new = imbinarize(img_gray,T1);
% img_gray(find(img_gray>T)) = 255;
% img_gray(find(img_gray<=T)) = 0;
% imshow(img_gray_new);

% 2. Split Intervals
img_gray_col = sum(img_gray_new,2)/pic_width;
T2 = graythresh(img_gray_col);
img_gray_col_new = imbinarize(img_gray_col,T2);
% imshow(img_gray_col_new);

staff_lines = find(img_gray_col_new == 0);
num_intervals = size(staff_lines,1)/5;
splits = [];
for i = 1:num_intervals-1
    splits = [splits round((staff_lines(5*i)+staff_lines(5*i+1))/2)];
end
gap = round(splits(2)-splits(1))/2;
splits = [staff_lines(1)-gap splits];
splits = [splits staff_lines(num_intervals*5)+gap];

for j = 1:length(staff_lines)
    idx = staff_lines(j);
    img_gray_new(idx,:) = 1;
end
% imshow(img_gray_new);

for k=1:num_intervals
    start = splits(k);
    final = splits(k+1);
    interval = double(img_gray_new(start:final,:));
    eval([ 'interval',num2str(k),'=','interval;']);
    [x, y] = size(interval);
    eval([ 'pic_length',num2str(k), ' = x' ]);
    eval([ 'interval',num2str(k),'_row =','sum(interval,1)/pic_length',num2str(k) ]);
%    interval =strcat(interval,'.jpg')
   ...
end
imshow(interval1);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                    %
%          Object Detection          %
%                                    %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
flag = 0;
count = 0;
notes_splits_1 = [];
for i=1:pic_width
    if (interval1_row(i) == 1)==flag
        count=count+1;
        flag = abs(flag-1);
        if rem(count,2) == 0
            notes_splits_1 = [notes_splits_1,i-1];
        else
            notes_splits_1 = [notes_splits_1,i];
        end
    end
end

flag = 0;
count = 0;
notes_splits_2 = [];
for i=1:pic_width
    if (interval2_row(i) == 1)==flag
        count=count+1;
        flag = abs(flag-1);
        if rem(count,2) == 0
            notes_splits_2 = [notes_splits_2,i-1];
        else
            notes_splits_2 = [notes_splits_2,i];
        end
    end
end
% 3. Clef Identification
% 暂时取巧，因为钢琴谱一定是高音谱号+低音谱号
a1 = notes_splits_1(1);
b1 = notes_splits_1(2);
c1 = staff_lines(4);
d1 = staff_lines(5);
clef_area_1 = interval1(a1:b1, c1:d1);
clef_value_1 = sum(sum(clef_area_1))/((b1-a1)*(d1-c1))

a2 = notes_splits_2(1);
b2 = notes_splits_2(2);
c2 = staff_lines(4+5);
d2 = staff_lines(5+5)
clef_area_2 = interval2(a2:b2,c2:d2);
clef_value_2 = sum(sum(clef_area_2))/((b2-a2)*(d2-c2))

% clef_area_3 = interval1(notes_splits_3(1):notes_splits_3(2),staff_lines(4+5*2):staff_lines(5+5*2));
% clef_value_3 = sum(sum(clef_area_3))
% 4. Key Signature Identification


% 5. Quarter and Eighth Note Detection


% 6. Whole Note and Half Note Detection


% 7. Dotted Notes


% 8. Rests





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                     %
%           Audio Synthesis           %
%                                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%






