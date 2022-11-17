# dbt Template for *Company X* Project (English)

This repo presents the ELT framework used in the analytics infrastructure implementation project at ***Company X***. Data is extracted from ***Data Source A*** and stored in ****Google Coud Storage/Amazon AWS/Databricks/etc***. Once this step is performed, the data is inserted into the ***Big Query/Redshift/etc*** where, effectively, the data transformation steps begin using dbt. The pipeline is orchestrated by ***Airflow/Other***.

## starting

In this project **it is necessary/not necessary** to be connected to a VPN to perform the data transformation, but **the VPN is necessary/not necessary** to use the pipeline orchestration tool (*** Airflow/other***). However, you must have access to the project repository, **GCP/Redshift/etc** (***Project Name**) and, if necessary, other data sources (***see Tech Lead for Project***).

### Cloning the project

First, you need to clone the repo locally. You must do this by accessing the project's repo on **bitbucket**. The project can be cloned via SSH or HTTPS using the `git clone` command in the link. **E.g.:**

- `git clone https://my_account@bitbucket.org/indiciumtech/project_x_dbt.git`

### Creating a virtual environment

You need to create a [virtual environment](https://pythonacademy.com.br/blog/python-e-virtualenv-como-programar-em-ambientes-virtuais) in the project's home folder (if you haven't already done so ).

- `python3 -m venv venv` or

- `py -3.8 -m venv venv` for Bash on Windows.

If you also have a version later than python 3.8 installed (python 3.9, for example, still contains bugs to run dbt), **prefer to use version 3.8**. The **version of Python** used in this project is **3.8.10**.

Also, the **virtual environment must be activated every time you open the project** through the command:

- `source venv/bin/activate` on Linux or

- `source venv/Scripts/activate` in bash on Windows, or else

- `.\venv\Scripts\activate.ps1` in Windows PowerShell

Make sure you are in the folder where the virtual environment was created. If it is enabled correctly, the terminal will have a flag pointing ***(venv)*** in front of the username before each command. To disable the virtual environment, just run:

- `deactivate`.

### Installing project libraries

The next step is to install the libraries listed in the **requirements.txt** file. This can be run via [pip](https://pypi.org/project/pip/):

- `pip install -r requirements.txt` or

- `python -m pip install -r requirements.txt` for some cases where the previous command doesn't work.

To check if all libraries were installed correctly, use `pip list` and validate the libraries and their respective versions listed.

### Configuring *profiles.yml*

The project already comes with the profiles configured in the repository's base folder, pulling the credentials from user-defined environment variables.

As a good practice, it will be necessary to create a .env file (dotenv) within your project environment, following the model of the `.env.example` file. To do this, just copy the file and paste it in the same location, renaming it from `.env` and fill in the information for host, schema, user, password and whatever else is necessary.

**Warning:** With this it will not be necessary to configure the `profiles.yml` file in the `.dbt` folder of your computer.

For local development, the following information is sufficient:

```python
export DBT_DB_NAME="<database_name>"
export DBT_DB_HOST="<host_address>"
export DBT_DB_PORT="<port>"
export DBT_DEV_USER="<your_bank_user>"
export DBT_DEV_PASSWORD="<your_bank_password>"
export DBT_DEV_SCHEMA="<your_bank_schema>"
export DBT_PROFILES_DIR='./'
```

After that, run the command `source .env` in your terminal (remember to enter with venv enabled)
To test if it's working, you can run `echo $DBT_DB_HOST` in the terminal. If it returns the value that was set, your environment variable is active.

If you don't have your credentials yet, request them from the **Project Tech Lead**.

***Be careful not to edit the profiles.yml file of the project's remote repo.***

*****************

### Updating the project in the development branch

Also, before running dbt, it is interesting that your **local repo is updated with the development branch.** When the remote repo is cloned, git automatically clones the main branch of the project (*master/main*) . To get the project **up to date with the *develop*** branch, just run a `git pull`:

- `git pull origin develop`

This process is standard for all Indicium projects. Further down there is a section that briefly explains how versioning works and its best practices.

## Running dbt

After successfully cloning the remote repo, it is recommended to run a test to confirm that **profiles.yml** and **dbt_project.yml** are configured and running correctly, and to double-check dependencies and necessary connections.

To do this, the command to be executed is:

- `dbt debug`

Assured that all settings are working correctly, you can start loading and transforming the data.

The load and transform steps are addressed to ***CGP/AWS/etc***. Each project member has its own dedicated schema, which should be used for its development.

To install the packages described in the *packages.yml* file, you can run:

- `dbt deps`

### Models:

The process to run the models can be done in several ways, either in a modular way (one specific model at a time), in order to run all the models at once, or in other ways. Below are the codes for each command:

*The command below runs all models at once:*

- `dbt run --full-refresh`

*To run only the specified model:*

- `dbt run -m model_that_want_to_run`

*To run the specified model and all models that this model depends on to generate:*

- `dbt run -m +model_want_to_run`

*To run the specified model and all models that are impacted by it:*

- `dbt run -m model_that_want_to_run+`

### Tests

Tests are modeled to ensure data quality. To run them, just:

- `dbt test`

**dbt test** runs all tests on data from created models. There are **two types of tests:**

- Validation of schemas, inserted in the **schema.yml* file;
- Test of data written in SQL.

The dbt test runs both types of tests and displays the results in the console.

When you make changes to dbt scripts, please **follow the dbt code style guidelines and conventions and also ensure that the models are running correctly and that all tests have passed.**

### Documentation in dbt

Good documentation for dbt models helps us to manage and understand the data sets involved in the project.

The data about each column must be documented in the different **schemas.yml** files for the different layers of data processing and transformation:
- Sources;
- Staging;
- Marts.

Each layer will have its own **schemas.yml** file. The more simplified documentation includes information about the tables, containing name and description. The more robust documentation includes the name of the tables, the name of their columns, their respective descriptions and also the tests of these columns.

#### Generating dbt docs

dbt provides a simple way to generate documentation for the project and render it as a website, the **dbt docs**.

Inside the project folder, there is a **packages.yml** file. In this file we put the packages and versions of the dbt dependencies used in the project. The command to install these dependencies is:

- `dbt deps`

It is important to note that, if this has not been done yet, it must be done before the next steps. Doing a `dbt run` before having `dbt deps` **will fail.**

After that, to generate the documentation, use the command:

- `dbt docs generate`

This command will generate a **target** folder. This folder itself becomes the documentation. To view the **dbt Docs**, that is, interpret the target folder, use:

- `dbt docs serve` - which hosts a local server and assembles documentation.

This dbt docs documentation is **very complete and very useful to understand how the model is organized and how the tables are related.** This is important both for the project management by the current members, as well as for the project management. knowledge thinking about future new members or scalability of other projects.

## Version control

Versioning is done with **git**. The project follows the [gitflow] workflow (https://danielkummer.github.io/git-flow-cheatsheet/index.pt_BR.html). This is mainly composed of a *master/main* branch, which is where the created files are available for production, and a *develop branch*, which aggregates recent changes made to the code. New features or changes must be developed in *branches* with the following pattern:

- `git checkout -b feature/new_branch_name`

This command creates a new branch called "feature/new_branch_name". **Prefer small commits with clear messages about what changes were made in each commit.**

A very important practice is to always try to leave the branch you are in, go back to *develop*, so that you can create a new branch. This avoids making changes on top of other changes that haven't even been approved for development yet. For that:

- `git checkout develop`
- `git checkout -b feature/new_branch_name`

After the **feature is finished, fully tested and with the changes saved in the repo**, create a PR (*Pull Request*) for the branch deveplop using the PR's template, add the PR link as a comment in the respective Task of the Project in Bitrix and share it with the members of the Project.

Once the PR is approved, the changes will be merged into the *develop* branch, where they will be tested along with the other steps of the project that run in parallel. Only then will the changes be merged and sent to production. Also, the sooner changes are merged into *develop*, the branch on which the PR was created can be closed in Bitbucket. **Please check our Wiki to better understand the full workflow!** [Wiki link](https://wiki.indicium.tech/en/analytics-engineering/process-work).

To understand more deeply the process of accumulating different branches for different features, read more about the workflow with [gitflow](https://www.atlassian.com/us/git/tutorials/comparing-workflows/gitflow- workflow). Once the _features_ are merged into the _master_ branch, these development branches can be deleted locally with:

- `git branch -d <branch>`

Further reading: [CI/CD](https://www.redhat.com/pt-br/topics/devops/what-is-ci-cd)
