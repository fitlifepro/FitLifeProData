/*
@isTest
public class FitnessTrainerTriggerHandlerTest {

    @isTest
    static void testInActiveTrainer() {
        // Create test data for Fitness_Trainer__c and Member__c
        Fitness_Trainer__c activeTrainer = new Fitness_Trainer__c(
            Name = 'Active Trainer',
            Working_Status__c = 'Active',
            Assigned_Members__c = 3
        );
        insert activeTrainer;

        Fitness_Trainer__c inactiveTrainer = new Fitness_Trainer__c(
            Name = 'Inactive Trainer',
            Working_Status__c = 'In-active',
            Assigned_Members__c = 2
        );
        insert inactiveTrainer;

        Member__c member1 = new Member__c(
            First_Name__c = 'Member 1',
            Fitness_Trainer__c = inactiveTrainer.Id
        );
        Member__c member2 = new Member__c(
            First_Name__c = 'Member 2',
            Fitness_Trainer__c = inactiveTrainer.Id
        );
        insert new List<Member__c> {member1, member2};

        // Create a trigger context for AFTER_INSERT
        Test.startTest();
        Fitness_Trainer__c newTrainers = new Fitness_Trainer__c(
                                                Name = 'Inactive Trainer',
                                                Working_Status__c = 'In-active',
                                                Assigned_Members__c = 2
                                            );
        FitnessTrainerTriggerHandler triggerHandler = new FitnessTrainerTriggerHandler();
        List<Fitness_Trainer__c> triggerNew = (List<Fitness_Trainer__c>)Trigger.New;
        triggerHandler.triggerNew = newTrainers;
        triggerHandler.inActiveTrainer();
        Test.stopTest();

        // Verify that the members have been assigned to active trainers
        List<Member__c> tempMember = new List<Member__c>();
        tempMember.add(member1.Id);
        tempMember.add(member2.Id);
        List<Member__c> updatedMembers = [SELECT Id, Name, Fitness_Trainer__c FROM Member__c WHERE Id IN :tempMember];
        for (Member__c member : updatedMembers) {
            System.assertEquals(activeTrainer.Id, member.Fitness_Trainer__c);
        }
    }
}
*/


@isTest()
public class FitnessTrainerTriggerHandler_Test {
    
	@isTest()
    public static void testDoAction(){
        
        List<Fitness_Trainer__c> trainer = new List<Fitness_Trainer__c>();
        trainer.add(new Fitness_Trainer__c(Name = 'Aradhya', Last_Name__c = 'Reddy', Phone_Number__c = '9658741235', Assigned_Members__c = 2,
                                                             Email__c = 'arashya@gmail.com', Working_Status__c = 'Active',
                                                             Availability_Schedule__c = 'Evening Slot - 4pm to 10pm', Salary__c = 50000));
        
        trainer.add(new Fitness_Trainer__c(Name = 'Abhi', Last_Name__c = 'naya', Phone_Number__c = '7778741235', 
                                                             Email__c = 'abhi@gmail.com', Working_Status__c = 'Active', Assigned_Members__c = 3,
                                                             Availability_Schedule__c = 'Evening Slot - 4pm to 10pm', Salary__c = 60000)); 
        
        trainer.add(new Fitness_Trainer__c(Name = 'Anhitha', Last_Name__c = 'Kumari', Phone_Number__c = '9585858585', 
                                                             Email__c = 'amrutha@gmail.com', Working_Status__c = 'Active', Assigned_Members__c = 2,
                                                             Availability_Schedule__c = 'Evening Slot - 4pm to 10pm', Salary__c = 70000));        
        insert trainer;
        Fitness_Trainer__c trainerRecord2 = [SELECT Id, Name, Assigned_Members__c, Working_Status__c FROM Fitness_Trainer__c WHERE Name = 'Abhi'];
        //List<Member__c> member = new List<Member__c>();
        Member__c member = new Member__c(First_Name__c = 'Anurag', Last_Name__c = 'Kumar ', Phone__c = '9685742547', 
            						Email__c = 'Anurag'  + '@gmail.com', District__c = 'Chennai', Area__c = 'Navalur', Fitness_Trainer__c = trainerRecord2.Id,
                              		DOB__c = date.valueOf('1981-10-15'));
                   
        //member.add(new Member__c(First_Name__c = 'Anoop ', Last_Name__c = 'Kulkarni ', Phone__c = '9632587456', 
        //    					Email__c = 'anoop@gmail.com', District__c = 'Chennai', Area__c = 'Navalur', 
        //                        DOB__c = date.valueOf('1979-10-20'))); 
        Test.startTest();        
		insert member; 
     
        Member__c memberRecord1 = [SELECT Id, First_Name__c,Fitness_Trainer__c FROM Member__c WHERE First_Name__c = 'Anurag'];
        system.debug('memberRecord1 :' + memberRecord1);
        Fitness_Trainer__c newTrainer = New Fitness_Trainer__c();
        Fitness_Trainer__c trainerRecord1 = [SELECT Id, Assigned_Members__c FROM Fitness_Trainer__c WHERE Name = 'Anhitha'];
        newTrainer.Id = memberRecord1.Fitness_Trainer__c;
        newTrainer.Working_Status__c = 'In-Active'; 
        system.debug('newTrainer :' + newTrainer);
        system.debug('trainerRecord2 :' + trainerRecord2);
        update newTrainer;        
        test.stopTest();
        
        FitnessTrainerTriggerHandler trainerHandler = new FitnessTrainerTriggerHandler();
    	trainerHandler.doAction();
        
        Fitness_Trainer__c trainerRecord = [SELECT Id, Assigned_Members__c FROM Fitness_Trainer__c WHERE Id =: memberRecord1.Fitness_Trainer__c];
        system.debug('Assigned_Members__c: '+ trainerRecord.Assigned_Members__c);
        System.assertEquals(0, trainerRecord.Assigned_Members__c, 'Assigned Member count should match');        
    }  

}