package com.muggle;

public class CalculateApplication {
    static public void main(String[] args) {
        int cnt = 0;
        Calculate calculate = new Calculate();

        while (true) {
            int a = 5;
            int b = 6;
            int sum = calculate.add(a, b);
            int sub = calculate.sub(a, b);

            System.out.println("#" + cnt);
            System.out.println("add " + a + ", " + b + " = " + sum);
            System.out.println("sub " + a + ", " + b + " = " + sub);

            try {
                Thread.sleep(500);
            } catch (InterruptedException e) {
                e.printStackTrace();
            }
            ++cnt;
        }
    }
}
