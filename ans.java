import java.io.*;
    import java.util.*;
    import java.util.regex.*;


    public class ans{
        public static void main(String[] args) throws IOException, ClassNotFoundException {
            String filename="passenger.pas";
            Set<Passenger> set=new LinkedHashSet<>();
            Passenger passenger[]=new Passenger[2];
            new StorePassenger(passenger);
            
            FileInputStream file = new FileInputStream(filename); 
            ObjectInputStream in = new ObjectInputStream(file);
            Passenger arrayReturned[]=(Passenger[])in.readObject();

            for(int i=0;i<arrayReturned.length;i++)
                set.add(arrayReturned[i]);

            TreeSet<Passenger> Ans1=new TreeSet<>(new SortbyEmail());
            Ans1.addAll(set);
            for(Passenger p:Ans1)
                System.out.println(p.toString());
            
                file.close();
                in.close();
        }
    }

    class SortbyEmail implements Comparator<Passenger>{
        public int compare(Passenger a,Passenger b){
            return a.pEmail.compareTo(b.pEmail);
        }
    }


    class Passenger implements Serializable{
        String passengerID,pName,pEmail;
        long pContactNo;
        int pAge;

        public Passenger(String passengerID,String pName,String pEmail,
            int pAge,long pContactNo){
            this.passengerID=passengerID;
            this.pName=pName;
            this.pEmail=pEmail;
            this.pAge=pAge;
            this.pContactNo=pContactNo;
        };

        public boolean verifyContact(long Ans){
            return (int)(Math.log10(Ans)+1)==10;
        }

        public String toString(){
            return new StringBuilder().append(passengerID+" ").append(pName+" ").append(pEmail+" ").append(pAge+" ").append(pContactNo+" ").toString();
        }
        public boolean verifyEmail(String Ans){
            if(Ans.length()>=20)
                return false;
            else{
                String regex="^[A-Za-z0-9]+@[A-Za-z0-9]+\\.[A-Za-z]+$";
                Pattern pattern=Pattern.compile(regex);
                return pattern.matcher(Ans).find(); 
            }
        }
       
    }

    class StorePassenger implements Serializable{
        StorePassenger(Passenger Ans[]) throws IOException{
            boolean flag=false;
            String filename="passenger.pas";
            Scanner sc=new Scanner(System.in);
            String passengerID,pName,pEmail;
            long pContactNo;
            int pAge;

            FileOutputStream file=new FileOutputStream(filename);
            ObjectOutputStream output=new ObjectOutputStream(file);

            for(int i=0;i<Ans.length;i++){
                System.out.println("Enter Fields");
                passengerID=sc.nextLine();
                pName=sc.nextLine();
                pEmail=sc.nextLine();
                pAge=Integer.parseInt(sc.nextLine());
                pContactNo=Long.parseLong(sc.nextLine());

                Ans[i]=new Passenger(passengerID,pName,pEmail,pAge,pContactNo);
                flag=(Ans[i].verifyContact(Ans[i].pContactNo)&&Ans[i].verifyEmail(Ans[i].pEmail));
                if(!flag)
                    break;
            }
            sc.close();
            if(flag){
                output.writeObject(Ans);
                output.close();
                file.close();
                System.out.println("Serialization Done");
            }
            else{
                System.out.println("Serialization Not Done");
            }
        }
    }