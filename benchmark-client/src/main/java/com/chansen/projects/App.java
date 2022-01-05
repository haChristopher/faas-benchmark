package com.chansen.projects;

import java.io.FileInputStream;
import java.io.IOException;
import java.util.Properties;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;



/**
 * @author Christopher
 * 
 *
 */
public class App 
{
    public static void main( String[] args ) throws InterruptedException
    {
    	String propFileName = "config.properties";
    	
        Properties prop = readProperties(propFileName);
        
        int maxPoolSize = Integer.parseInt(prop.getProperty("MaxThreadPoolSize"));
        
        Runnable r1 = new HTTPRunner();
        
        ExecutorService pool = Executors.newFixedThreadPool(maxPoolSize);
        
        pool.execute(r1); 
        
        pool.awaitTermination(1000, TimeUnit.SECONDS);
          
        pool.shutdown();  
    }
    
    public static Properties readProperties(String fileName) {
    	Properties prop = new Properties();

    	try {
			FileInputStream fileInput = new FileInputStream(fileName);
			prop.load(fileInput);
		} catch (IOException e) {
			System.out.println("Could not load properties file ....");
			e.printStackTrace();
		}
    	
    	return prop;
    }
}
