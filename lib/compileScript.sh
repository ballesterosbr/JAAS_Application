#!/bin/bash

echo "Compilando clase PlainLoginModule.java"
javac -cp .:bcprov-jdk15on-160.jar PlainLoginModule.java 
echo "Compilando clase PlainPasswdModule.java"
javac -cp .:bcprov-jdk15on-160.jar PlainPasswdModule.java 
echo "Compilando clase PlainUserPrincipal.java"
javac PlainUserPrincipal.java
echo "Compilando clase PlainRolePrincipal.java"
javac PlainRolePrincipal.java
