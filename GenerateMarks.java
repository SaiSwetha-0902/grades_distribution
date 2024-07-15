/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

 package com.tpt.dm.data;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Random;

/**
 *
 * @author rajendra
 */

 public class GenerateMarks {

    /**
     * Prints the key-value pairs of a map.
     * @param map The map to print.
     */
    public void printMap(Map map) {
        Iterator iter = map.keySet().iterator();
        int ctr = 1;
        while (iter.hasNext()) {
            Object key = iter.next();
            Object val = map.get(key);
            System.out.format("%3d - %s - %5.2f\n", (ctr++), key, val);
        }
        System.out.println("\n\n");
    }

    /**
     * Generates a map of student roll numbers and their corresponding grades based on the given parameters.
     * @param num The number of students.
     * @param seed The seed value for randomization.
     * @return A map of student roll numbers and their grades.
     */
    public Map<Character, Integer> getIDGrade(int num, int seed) {
        Random rand = new Random(seed);
        Map<String, Float> mapRG = new HashMap<>();
        String rollno = "";
        int year = 2020, count = 1000;
        for (int i = 0; i < num; i++) {
            float marks = 1.0f + Math.abs(rand.nextInt(98)) + Math.abs(rand.nextFloat());
            rollno = "S" + year + "001" + count++ + "";
            mapRG.put(rollno, marks);
        }
    
        // Calculate maximum, minimum, and average marks
        float maximumMarks = Float.MIN_VALUE;
        float minimumMarks = Float.MAX_VALUE;
        float totalMarks = 0;
        for (float marks : mapRG.values()) {
            totalMarks += marks;
            if (marks > maximumMarks)
                maximumMarks = marks;
            if (marks < minimumMarks)
                minimumMarks = marks;
        }
        float averageMarks = totalMarks / num;
        float passingMinimum = Math.min(averageMarks / 2, maximumMarks / 3);
    
        // Assign grades
        Map<String, Character> gradeMap = new HashMap<>();
        Map<Character, Integer> gradeCounts = new HashMap<>();
        for (Map.Entry<String, Float> entry : mapRG.entrySet()) {
            String roll = entry.getKey();
            float marks = entry.getValue();
            char grade;
            if (marks < passingMinimum) {
                continue; // Skip 'F' grades
            } else {
                // Assign grades based on fixed distribution
                grade = getGradeFromDistribution(rand);
            }
            gradeMap.put(roll, grade);
            gradeCounts.put(grade, gradeCounts.getOrDefault(grade, 0) + 1);
        }
    
        // Adjust grades counts
        int fCount = num - gradeCounts.values().stream().mapToInt(Integer::intValue).sum();
        if (fCount > 0) {
            gradeCounts.put('F', fCount); // Assign remaining 'F' grades
        }
    
        int oCount = gradeCounts.getOrDefault('O', 0);
        int pCount = gradeCounts.getOrDefault('P', 0);
        int aCount = gradeCounts.getOrDefault('A', 0);
        int dCount = gradeCounts.getOrDefault('D', 0);
        int bCount = gradeCounts.getOrDefault('B', 0);
        int cCount = gradeCounts.getOrDefault('C', 0);
    
        // Adjust counts to follow near-normal distribution
        while (!isNearNormal(oCount, pCount) || !isNearNormal(aCount, dCount) || !isNearNormal(bCount, cCount)) {
            if (oCount > pCount) {
                oCount--;
                pCount++;
            } else if (oCount < pCount) {
                oCount++;
                pCount--;
            }
            if (aCount > dCount) {
                aCount--;
                dCount++;
            } else if (aCount < dCount) {
                aCount++;
                dCount--;
            }
            if (bCount > cCount) {
                bCount--;
                cCount++;
            } else if (bCount < cCount) {
                bCount++;
                cCount--;
            }
        }
    
        gradeCounts.put('O', oCount);
        gradeCounts.put('P', pCount);
        gradeCounts.put('A', aCount);
        gradeCounts.put('D', dCount);
        gradeCounts.put('B', bCount);
        gradeCounts.put('C', cCount);
    
        return gradeCounts;
    }

    /**
     * Assigns a grade based on a fixed distribution.
     * @param rand The Random object.
     * @return The assigned grade.
     */
    private char getGradeFromDistribution(Random rand) {
        // Assign grades based on fixed distribution
        int r = rand.nextInt(100);
        if (r < 10)
            return 'O';
        else if (r < 20)
            return 'P';
        else if (r < 30)
            return 'A';
        else if (r < 40)
            return 'D';
        else if (r < 70)
            return 'B';
        else
            return 'C';
    }

    /**
     * Checks if two counts are near normal distribution.
     * @param count1 The first count.
     * @param count2 The second count.
     * @return True if counts are near normal distribution, false otherwise.
     */
    private boolean isNearNormal(int count1, int count2) {
        return Math.abs(count1 - count2) <= 1;
    }

    /**
     * The main method to generate and analyze student marks data.
     * @param args The command-line arguments.
     */
    public static void main(String[] args) {
        int seed = 10143;
        seed = (args.length >= 1) ? Integer.parseInt(args[0]) : seed;
        GenerateMarks gdw = new GenerateMarks();
        Random rand = new Random(seed);
        int num = 20 + Math.abs(rand.nextInt() % 100); // The number of students is generated randomly
        num = (args.length >= 2) ? Integer.parseInt(args[1]) : num; // Fixed Set of Students

        System.out.println("Total = " + num);
        Map<Character, Integer> gradeMap = gdw.getIDGrade(num, seed);
    }
}