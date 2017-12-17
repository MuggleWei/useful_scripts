package com.muggle;

import org.junit.Assert;
import org.junit.Test;

public class CalculateTest {
    @Test
    public void AddTest() {
        int a = 5;
        int b = 6;
        Calculate calculate = new Calculate();

        int sum = calculate.add(a, b);
        Assert.assertEquals(sum, a+b);

        int sub = calculate.sub(a, b);
        Assert.assertEquals(sum, a+b);
    }
}
