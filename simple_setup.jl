##############################################################################
##
## Using the datasets
##
##############################################################################

using RDatasets


RDatasets.datasets()

iris = dataset("datasets", "iris")

names(iris)

size(iris)

first(iris, 10) # deprecated-> head(iris)

last(iris, 10) # deprecated-> tail(iris, 10)

by(iris, :Species, nrow) # looking at a row count in eaah col.

describe(iris) # looking at some basic stats

describe(iris, :q25, :q75, :first, :last)

describe(iris, :all)


##############################################################################
##
## Using simple statistics
##
##############################################################################

using Statistics


mean(iris[:SepalLength])

median(iris[:SepalLength])

std(iris[:SepalLength])

# cor() -> how the values are correlated.
for x in names(iris)[1:end-1]
    for y in names(iris)[1:end-1]
        println("$x \t $y \t $(cor(iris[!,x], iris[!,y]))")
    end
    println("---------------------------------------------")
end

# cov() -> compute the covariance of the values in the dataset.
for x in names(iris)[1:end-1]
    for y in names(iris)[1:end-1]
        println("$x \t $y \t $(cov(iris[!,x], iris[!,y]))")
    end
    println("---------------------------------------------")
end

rand(iris[!, :SepalLength])

rand(iris[!, :SepalLength], 5)

sepallength = Array(iris[!, :SepalLength]) # convert one of the col. to an array

irisarr = convert(Matrix, iris[:,:]) # convert the whole dataframe to a matrix



##############################################################################
##
## Visualizing the Iris flowers data
##
##############################################################################

using Gadfly

plot(iris, x=:SepalLength, y=:PetalLength, color=:Species)

plot(iris, x=:Species, y=:PetalLength, Geom.boxplot)

plot(iris, x=:PetalLength, color=:Species, Geom.histogram)

plot(iris, x=:PetalWidth, color=:Species, Geom.histogram)

plot(iris, x=:PetalWidth, y=:PetalLength, color=:Species)


##############################################################################
##
## Loading and saving the data
##
##############################################################################

iris[1:3, [:PetalLength, :PetalWidth]] # define a new dataframe with the first three rows

iris[trues(150), [:PetalLength, :PetalWidth]]  # select all 150 rows that are all initialized as true

test_data = iris[rand(150) .<=0.1, [:PetalLength, :PetalWidth, :Species]] # 10% of the sample data


using CSV


CSV.write("test_data.csv", test_data)

td = CSV.read("test_data.csv")


using Feather


Feather.write("test_data.feather", test_data)

Feather.read("test_data.feather")
