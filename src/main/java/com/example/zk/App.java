package com.example.zk;
import java.util.Properties;
import java.io.FileInputStream;
import java.io.IOException;

public class App
{
    public static void main( String[] args )
    {
        String configFileName = "config.ini";
        if(args.length > 0){
            configFileName = args[0];
        }
        System.out.println("Loading config file: " + configFileName);
        Properties properties = new Properties();
        String serverIP = "localhost";
        String zNode = "/Clients/Client1";
        String scriptPath = "scripts/";
        try (FileInputStream fis = new FileInputStream(configFileName)) {
            properties.load(fis);

            serverIP = properties.getProperty("ServerIP");
            zNode = properties.getProperty("ZNode");
            scriptPath = properties.getProperty("scriptPath");

            System.out.println("ServerIP: " + serverIP);
            System.out.println("ZNode: " + zNode);
            System.out.println("scriptPath: " + scriptPath);

        } catch (IOException e) {
            e.printStackTrace();
        }
        String[] arguments = new String[] { serverIP,zNode,
                "output.txt",scriptPath,configFileName };
        System.out.println( "Start Zookeeper Client!" );
        Executor.main(arguments);
    }
}
