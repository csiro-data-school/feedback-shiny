outputPath <- "../data/responses.csv"

if(!dir.exists(dirname(outputPath))) dir.create(dirname(outputPath))
if(!file.exists(outputPath)) file.create(outputPath)