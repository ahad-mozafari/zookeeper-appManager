package com.example.zk;


public class App 
{
    public static void main( String[] args )
    {
        String[] arguments = new String[] { "localhost","/Clients/Client1",
                "output.txt","src/main/scripts/count.cmd/" };
        System.out.println( "Start Zookeeper Client!" );
        Executor.main(arguments);
    }
}
