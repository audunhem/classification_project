function mv = vow_mean(vow_n)
vowels;
for i = 1:size(all_data, 2)
    F = all_data(:,i);
    v = F(find(vowel_code==vow_n));
    mv(i) = mean(v);
end
end
