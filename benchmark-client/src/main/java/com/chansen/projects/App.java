package com.chansen.projects;

import java.io.FileInputStream;
import java.io.IOException;
import java.lang.management.BufferPoolMXBean;
import java.util.Properties;
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.LinkedBlockingDeque;
import java.util.concurrent.TimeUnit;

import org.json.simple.JSONObject;



/**
 * 
 * @author Christopher
 *
 */
public class App 
{
    public static void main( String[] args ) throws InterruptedException
    {
    	String propFileName = "config.properties";
    	BlockingQueue<JSONObject> queue = new LinkedBlockingDeque<>();
    	Properties prop = readProperties(propFileName);
    	
        
        int maxPoolSize = Integer.parseInt(prop.getProperty("MaxThreadPoolSize"));
        int requestTimeout = Integer.parseInt(prop.getProperty("RequestTimeoutInMs"));
        ExecutorService pool = Executors.newFixedThreadPool(maxPoolSize);
        
        // Setup logging to CSV Thread
        Runnable logger = new CSVRunner(prop.getProperty("CSVPath"), queue);
        
        // Setup HttpRunner
        Runnable r1 = new HTTPRunner(prop.getProperty("Endpoint"), queue, requestTimeout);
        
        pool.execute(logger);

        // Read data file or generate data here
        
        // Read in Benchmark Scenario configuration
        
        // TODO is it allowed to execute one thread multiple times Create multiple threads
        for (int i = 0; i < 3; i++) {
        	pool.execute(r1); 
		}
        
        // TODO How to terminate tasks on their own
        pool.shutdown();
        pool.awaitTermination(10, TimeUnit.SECONDS);
        pool.shutdownNow();
        
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
