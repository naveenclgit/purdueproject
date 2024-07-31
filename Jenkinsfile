pipeline
{
	agent any
	stages
	{
		stage('Code Checkout')
		{
			steps
			{
				git 'https://github.com/naveenclgit/purdueproject.git'
			}
		}
		
		stage('Code Compile')
		{
			steps
			{
				mvn compile
			}
		}

		stage('Unit Test')
		{
			steps
			{
				mvn test
			}
		}

		stage('Code packaging')
		{
			steps
			{
				mvn package
			}
		}
   }
}
