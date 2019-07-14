#This is how I run my code

#First, I create the class from the jflex
	java -jar jflex-full-1.7.0.jar xmlc.jflex
#Then, I compile the class
	javac transform.java
#I create a jar file
	jar -cfe xml2c.jar transform transform.class
#I execute the jar file with an example, in this case the mult example
	java -jar xml2c.jar mult.xml

#We can run the remaining examples with the same command
	java -jar xml2c.jar one.xml
	java -jar xml2c.jar two.xml
	java -jar xml2c.jar three.xml