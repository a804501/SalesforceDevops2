/**
* Name: Calculator class
* Author: Release Manager
* Modified: Developer 2
* Date: 23/10/2024
****/
public with sharing class Calculator {
    public Calculator() {
    }
    public integer sub(integer a, integer b) {
        return a-b;
    }
    public Integer add(integer a, integer b){
        return a+b;
    }
    public integer mul(integer a, integer b){
        return a*b;
    }
}