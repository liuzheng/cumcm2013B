clc;clear;
path = '3';
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
START =[];
for i = 1 : length(file)
    left(find(S(:,i)==min(S(:,i)))) = i;
    if img(:,1,i)==255
        START(end+1) = i;
    end
end
Img = 1:i;
j = 1;
for i = 14:14
%for i = 1:length(START)
    STARt=START(i);
    Img(find(Img==STARt)) = [];
    IMG{i} = img(:,:,STARt);
    while 1
        IMG{i} = [IMG{i} img(:,:,find(S(STARt,:)==min(S(STARt,:)))) ];
        figure;imshow(IMG{i});
        STARt = find(S(STARt,:)==min(S(STARt,:)));
        Img(find(Img==STARt)) = [];
        if ~sum(find(S(STARt,:)==min(S(STARt,:)))~=START)
            break
        end
    end
        figure;imshow(IMG{i});
end
%imshow(IMG)
