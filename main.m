clc;clear;
path = '附件1';
file = dir([path '/*.bmp']);
img = [];
for i = 1 : length(file)
    img(:,:,i) = imread([path '/' file(i).name]);
end
for j = 1 :length(file)
    s = 0;ss = 0;
    for i = 1 : length(file)
        if j==i
            continue
        end
        ss = s;
        s = sum((img(:,2,j)-img(:,end-1,i)).^2);
        if s>ss
            ss = s;
            left(j) = i;
        end
    end
end
left
