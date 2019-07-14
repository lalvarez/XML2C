JAR=./jflex-full-1.7.0.jar

transform.class:	transform.java	
	javac transform.java

transform.java:	xmlc.jflex
	java -jar $(JAR) xmlc.jflex

clean:
	rm -rf transform.java transform.class
