/**
 * 
 */
package com.chansen.projects;

import java.io.IOException;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;

/**
 * @author Christopher
 *
 */
public class HTTPRunner implements Runnable{
	
	private String endpoint;
	
	public HTTPRunner(String endpoint) {
		super();
		this.endpoint = endpoint;
		
	}
	
	

	@Override
	public void run() {
		// TODO Auto-generated method stub
		System.out.println("Running task 1");
		
		URL url;
		try {
			url = new URL(this.endpoint);
			HttpURLConnection con = (HttpURLConnection) url.openConnection();
			con.setRequestMethod("GET");
			
			int status = con.getResponseCode();
			System.out.println(status);
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		
	}

}
