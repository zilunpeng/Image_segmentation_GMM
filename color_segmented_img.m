function labeled_img = color_segmented_img(segmented_img,K,orginal_size)
    color_rng = linspace(0,255,K);
    for k=1:K
        segmented_img(segmented_img==k) = color_rng(k);
    end
    labeled_img = reshape(segmented_img,orginal_size);
end