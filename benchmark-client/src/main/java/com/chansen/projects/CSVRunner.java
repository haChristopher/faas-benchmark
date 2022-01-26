package com.chansen.projects;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.concurrent.BlockingQueue;
import java.util.concurrent.TimeUnit;

import org.json.simple.JSONObject;

public class CSVRunner implements Runnable {
	/*
	 * Runner which reads logs from queue, converts and dumps them periodically to a
	 * CSV file.
	 */

	private String filepath;
	private BlockingQueue<JSONObject> queue;
	private final long queueTimeout = 5;
	private final TimeUnit queueTimeoutUnit = TimeUnit.SECONDS;
	private static final String DELIMETER = ",";
	private static final String LINE_SEPERATOR = "\n";
	private static String[] KEYS = { "statusCode", "method", "timeIn", "timeOut", "coldStart", "timeSend",
			"timeReceived" };

	public CSVRunner(String filepath, BlockingQueue<JSONObject> queue) {
		super();
		this.filepath = filepath;
		this.queue = queue;
	}

	@Override
	public void run() {
		this.writeQueueToCSV();

	}

	private String createCsvString(JSONObject json) {
		StringBuilder result = new StringBuilder();
		for (String key : KEYS) {
			result.append(json.getOrDefault(key, "notSet"));
			result.append(DELIMETER);
		}

		// Remove laster Delimeter and add Line Seperator
		if (result.length() > 0) {
			result.setLength(result.length() - 1);
			result.append(LINE_SEPERATOR);
		}

		return result.length() > 0 ? result.toString() : "";
	}

	public void writeQueueToCSV() {

		File csvFile = new File(this.filepath);
		Boolean csvFileExists = csvFile.exists();

		try (PrintWriter pwriter = new PrintWriter(new BufferedWriter(new FileWriter(csvFile, true)))) {
			
			// Write header line if it is a new file
			if (!csvFileExists) {
				String headers = String.join(DELIMETER, KEYS);
				pwriter.write(headers);
				pwriter.append(LINE_SEPERATOR);
			}

			// Write results from queue to CSV file until interrupted
			while (!Thread.currentThread().isInterrupted()) {
				try {
					JSONObject line = queue.poll(this.queueTimeout, this.queueTimeoutUnit);
					if (line != null) {
						System.out.println(createCsvString(line));
						pwriter.write(createCsvString(line));
					}
				} catch (InterruptedException e) {
					Thread.currentThread().interrupt();
				}
			}

		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e1) {
			e1.printStackTrace();
		}

	}
}
