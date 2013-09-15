clc;clear;
path = '1';
file = dir([path '/*.bmp']);
img = [];
for i = 1 : length(file)
    img(:,:,i) = imread([path '/' file(i).name]);
end
for j = 1 : length(file)
    for i = 1 : length(file)
        if j==i
            S(j,i) = Inf;
            continue
        end
        S(j,i) = sum((img(:,end,j)-img(:,1,i)).^2);
    end
end
for i = 1 : length(file)
    left(find(S(:,i)==min(S(:,i)))) = i;
    if img(:,end,i)==255
        START = i;
    end
end
IMG = img(:,:,START);

for i = 1:length(file)-1
    IMG = [img(:,:,find(left==START)) IMG ];
    START = find(left==START);
end
imshow(IMG)