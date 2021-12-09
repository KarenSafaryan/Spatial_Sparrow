function index = selectRandomIndex(vectorList)
    indices = randperm(numel(vectorList));
    index = vectorList(indices(1));
end