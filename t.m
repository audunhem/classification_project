function [train, test]= t(vow_n)
vowels;
n = find(vowel_code==vow_n); 
set = zeros(139, 14);

for i = n(1):n(size(n,2))
    set(i-(n(1)-1),:) = all_data(i,:);
end

train = set(1:70, :);
test = set(71:139, :);
end
