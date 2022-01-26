/**
 * 
 */
package com.chansen.projects;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.concurrent.BlockingQueue;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;


/**
 * @author Christopher
 *
 */
public class HTTPRunner implements Runnable{
	
	private String endpoint;
	private BlockingQueue<JSONObject> queue;
	private int timeoutInMs = 5000;
	
	public HTTPRunner(String endpoint, BlockingQueue<JSONObject> queue, int timeoutInMs) {
		super();
		this.endpoint = endpoint;
		this.queue = queue;
		this.timeoutInMs = timeoutInMs;
		
	}
	
	
	private JSONObject requestResultToJson(HttpURLConnection con) throws IOException, ParseException {
		
		JSONObject jsonResponse = new JSONObject();
		JSONParser parser = new JSONParser();
		
		
		// Check status code to extract different information on error
		if (100 <= con.getResponseCode() && con.getResponseCode() <= 399) {
			BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			jsonResponse = (JSONObject) parser.parse(br);
		} else {
			BufferedReader br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
			jsonResponse = (JSONObject) parser.parse(br);
		}
		
		// Set additional information from the request
		jsonResponse.put("statusCode", con.getResponseCode());
		jsonResponse.put("method", con.getRequestMethod());
		
		
		return jsonResponse;
	}
	

	@Override
	public void run() {
		System.out.println("Running task 1");
		
		// If request fails this will stay empty
		JSONObject resultEntry = new JSONObject();
		
		try {
			URL url = new URL(this.endpoint);
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con.setRequestProperty("Content-length", "0");
			// con.setRequestProperty("Content-Type", "application/json; utf-8");
			con.setRequestMethod("GET");
			con.setConnectTimeout(this.timeoutInMs);
			con.setUseCaches(false);
			
			long startTime = System.currentTimeMillis();
			con.connect();
			long endTime = System.currentTimeMillis();
						
			// Extract information
			resultEntry= this.requestResultToJson(con);
			resultEntry.put("timeSend", startTime);
			resultEntry.put("timeReceived", endTime);
			
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			this.queue.add(resultEntry);
		}

		
	}

}
