#Importing training and test data and not converting strings(characters) to factors
trainData<- read.csv("C:/Users/sai-g/Desktop/Goutham/3.App.Multivariate Analysis/Project/titanic_train.csv", header = TRUE, stringsAsFactors = FALSE)
testData<- read.csv("C:/Users/sai-g/Desktop/Goutham/3.App.Multivariate Analysis/Project/titanic_test.csv", header = TRUE, stringsAsFactors = FALSE)


counts <- table(trainData$Survived, trainData$Sex)
barplot(counts, xlab = "Gender", ylab = "Number of People", main = "survived and deceased between male and female")
counts[2] / (counts[1] + counts[2])
counts[4] / (counts[3] + counts[4])


Pclass_survival <- table(trainData$Survived, trainData$Pclass)
barplot(Pclass_survival, xlab = "Cabin Class", ylab = "Number of People",
        main = "survived and deceased between male and female")
Pclass_survival[2] / (Pclass_survival[1] + Pclass_survival[2])
Pclass_survival[4] / (Pclass_survival[3] + Pclass_survival[4])
Pclass_survival[6] / (Pclass_survival[5] + Pclass_survival[6])

trainData = trainData[-c(1,9:12)]

trainData$Sex = gsub("female", 1, trainData$Sex)
trainData$Sex = gsub("^male", 0, trainData$Sex)

master_vector = grep("Master.",trainData$Name, fixed=TRUE)
miss_vector = grep("Miss.", trainData$Name, fixed=TRUE)
mrs_vector = grep("Mrs.", trainData$Name, fixed=TRUE)
mr_vector = grep("Mr.", trainData$Name, fixed=TRUE)
dr_vector = grep("Dr.", trainData$Name, fixed=TRUE)


master_age = round(mean(trainData$Age[trainData$Name == "Master"], na.rm = TRUE), digits = 2)
miss_age = round(mean(trainData$Age[trainData$Name == "Miss"], na.rm = TRUE), digits =2)
mrs_age = round(mean(trainData$Age[trainData$Name == "Mrs"], na.rm = TRUE), digits = 2)
mr_age = round(mean(trainData$Age[trainData$Name == "Mr"], na.rm = TRUE), digits = 2)
dr_age = round(mean(trainData$Age[trainData$Name == "Dr"], na.rm = TRUE), digits = 2)

for(i in master_vector) {
  trainData$Name[i] = "Master"
}
for(i in miss_vector) {
  trainData$Name[i] = "Miss"
}
for(i in mrs_vector) {
  trainData$Name[i] = "Mrs"
}
for(i in mr_vector) {
  trainData$Name[i] = "Mr"
}
for(i in dr_vector) {
  trainData$Name[i] = "Dr"
}

master_age = round(mean(trainData$Age[trainData$Name == "Master"], na.rm = TRUE), digits = 2)
miss_age = round(mean(trainData$Age[trainData$Name == "Miss"], na.rm = TRUE), digits =2)
mrs_age = round(mean(trainData$Age[trainData$Name == "Mrs"], na.rm = TRUE), digits = 2)
mr_age = round(mean(trainData$Age[trainData$Name == "Mr"], na.rm = TRUE), digits = 2)
dr_age = round(mean(trainData$Age[trainData$Name == "Dr"], na.rm = TRUE), digits = 2)

for (i in 1:nrow(trainData)) {
  if (is.na(trainData[i,5])) {
    if (trainData$Name[i] == "Master") {
      trainData$Age[i] = master_age
    } else if (trainData$Name[i] == "Miss") {
      trainData$Age[i] = miss_age
    } else if (trainData$Name[i] == "Mrs") {
      trainData$Age[i] = mrs_age
    } else if (trainData$Name[i] == "Mr") {
      trainData$Age[i] = mr_age
    } else if (trainData$Name[i] == "Dr") {
      trainData$Age[i] = dr_age
    } else {
      print("Uncaught Title")
    }
  }
}

trainData["Child"]<-NA
for (i in 1:nrow(trainData)) {
  if (trainData$Age[i] <= 12) {
    trainData$Child[i] = 1
  } else {
    trainData$Child[i] = 2
  }
}


trainData["Family"] = NA

for(i in 1:nrow(trainData)) {
  x = trainData$SibSp[i]
  y = trainData$Parch[i]
  trainData$Family[i] = x + y + 1
}

trainData["Mother"] =NA
for(i in 1:nrow(trainData)) {
  if(trainData$Name[i] == "Mrs" & trainData$Parch[i] > 0) {
    trainData$Mother[i] = 1
  } else {
    trainData$Mother[i] = 2
  }
}


PassengerId = testData[1]
testData = testData[-c(1, 8:11)]

testData$Sex = gsub("female", 1, testData$Sex)
testData$Sex = gsub("^male", 0, testData$Sex)

test_master_vector = grep("Master.",testData$Name)
test_miss_vector = grep("Miss.", testData$Name)
test_mrs_vector = grep("Mrs.", testData$Name)
test_mr_vector = grep("Mr.", testData$Name)
test_dr_vector = grep("Dr.", testData$Name)

for(i in test_master_vector) {
  testData[i, 2] = "Master"
}
for(i in test_miss_vector) {
  testData[i, 2] = "Miss"
}
for(i in test_mrs_vector) {
  testData[i, 2] = "Mrs"
}
for(i in test_mr_vector) {
  testData[i, 2] = "Mr"
}
for(i in test_dr_vector) {
  testData[i, 2] = "Dr"
}

test_master_age = round(mean(testData$Age[testData$Name == "Master"], na.rm = TRUE), digits = 2)
test_miss_age = round(mean(testData$Age[testData$Name == "Miss"], na.rm = TRUE), digits =2)
test_mrs_age = round(mean(testData$Age[testData$Name == "Mrs"], na.rm = TRUE), digits = 2)
test_mr_age = round(mean(testData$Age[testData$Name == "Mr"], na.rm = TRUE), digits = 2)
test_dr_age = round(mean(testData$Age[testData$Name == "Dr"], na.rm = TRUE), digits = 2)

for (i in 1:nrow(testData)) {
  if (is.na(testData[i,4])) {
    if (testData[i, 2] == "Master") {
      testData[i, 4] = test_master_age
    } else if (testData[i, 2] == "Miss") {
      testData[i, 4] = test_miss_age
    } else if (testData[i, 2] == "Mrs") {
      testData[i, 4] = test_mrs_age
    } else if (testData[i, 2] == "Mr") {
      testData[i, 4] = test_mr_age
    } else if (testData[i, 2] == "Dr") {
      testData[i, 4] = test_dr_age
    } else {
      print(paste("Uncaught title at: ", i, sep=""))
      print(paste("The title unrecognized was: ", testData[i,2], sep=""))
    }
  }
}

#We do a manual replacement here, because we weren't able to programmatically figure out the title.
#We figured out it was 89 because the above print statement should have warned us.
testData[89, 4] = test_miss_age

testData["Child"] = NA

for (i in 1:nrow(testData)) {
  if (testData[i, 4] <= 12) {
    testData[i, 7] = 1
  } else {
    testData[i, 7] = 1
  }
}

testData["Family"] = NA

for(i in 1:nrow(testData)) {
  testData[i, 8] = testData[i, 5] + testData[i, 6] + 1
}

testData["Mother"] = NA

for(i in 1:nrow(testData)) {
  if(testData[i, 2] == "Mrs" & testData[i, 6] > 0) {
    testData[i, 9] = 1
  } else {
    testData[i, 9] = 2
  }
}

my_forest <- randomForest(as.factor(Survived) ~ Pclass  + Age + Mother  + Family + Sex*Pclass ,
                          data = trainData, importance = TRUE, ntree = 1000)

# Make your prediction using the test set
survival <- predict(my_forest, testData)

kaggle.sub <- cbind(PassengerId,survival)
colnames(kaggle.sub) <- c("PassengerId", "Survived")
write.csv(kaggle.sub, file = "C:\\Users\\sai-g\\Desktop\\Goutham\\3.App.Multivariate Analysis\\Project\\Kaggle_RForest.csv", row.names = FALSE)