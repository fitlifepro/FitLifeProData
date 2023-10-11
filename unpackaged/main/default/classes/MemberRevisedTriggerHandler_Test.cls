@isTest()
public class MemberRevisedTriggerHandler_Test {
    
	@isTest()
    public static void testDoAction(){
        
        List<Fitness_Trainer__c> trainer = new List<Fitness_Trainer__c>();
        trainer.add(new Fitness_Trainer__c(Name = 'Aradhya', Last_Name__c = 'Reddy', Phone_Number__c = '9658741235', 
                                                             Email__c = 'arashya@gmail.com', Working_Status__c = 'Active',
                                                             Availability_Schedule__c = 'Evening Slot - 4pm to 10pm', Salary__c = 50000));
        
        trainer.add(new Fitness_Trainer__c(Name = 'Abhi', Last_Name__c = 'naya', Phone_Number__c = '7778741235', 
                                                             Email__c = 'abhi@gmail.com', Working_Status__c = 'Active',
                                                             Availability_Schedule__c = 'Evening Slot - 4pm to 10pm', Salary__c = 60000)); 
        
        trainer.add(new Fitness_Trainer__c(Name = 'Amrutha', Last_Name__c = 'Kumari', Phone_Number__c = '9585858585', 
                                                             Email__c = 'amrutha@gmail.com', Working_Status__c = 'In-Active',
                                                             Availability_Schedule__c = 'Evening Slot - 4pm to 10pm', Salary__c = 70000));        
        insert trainer;
        //List<Member__c> member = new List<Member__c>();
        Member__c member = new Member__c(First_Name__c = 'Anurag ', Last_Name__c = 'Kumar ', Phone__c = '9685742547', 
            						Email__c = 'Anurag'  + '@gmail.com', District__c = 'Chennai', Area__c = 'Navalur', 
                              		DOB__c = date.valueOf('1981-10-15'));
                   
        //member.add(new Member__c(First_Name__c = 'Anoop ', Last_Name__c = 'Kulkarni ', Phone__c = '9632587456', 
        //    					Email__c = 'anoop@gmail.com', District__c = 'Chennai', Area__c = 'Navalur', 
        //                        DOB__c = date.valueOf('1979-10-20'))); 
        Test.startTest();           
		insert member;        
        member.Last_Name__c = 'Reddy'; 
        update member;        
        delete member;
        undelete member;
        test.stopTest();
        
        MemberRevisedTriggerHandler memberHandler = new MemberRevisedTriggerHandler();
    	memberHandler.doAction();
        
        Fitness_Trainer__c trainerRecord = [SELECT Id, Assigned_Members__c FROM Fitness_Trainer__c WHERE Name = 'Aradhya'];
        system.debug('Assigned_Members__c: '+ trainerRecord.Assigned_Members__c);
        System.assertEquals(1, trainerRecord.Assigned_Members__c, 'Assigned Member count should match');        
    }  

}