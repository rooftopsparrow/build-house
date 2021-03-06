# Building a House

Jonathan Nicholson  
Dr. Aaron Gordon  
Available on [github](https://github.com/rooftopsparrow/build-house.git).  
Also includes functions from 
[lisp-exploration](https://github.com/rooftopsparrow/lisp-exploration).

## Preface

When building a house, the order that jobs are done is important. Sometimes a
specific task must precede another task while sometimes the ordering for a pair
of tasks is unrelated.

## Assignment:

You are to write the following functions:

1. sum - takes the list of tasks as an argument then returns the sum of all
of the days needed for the individual jobs.

2. predecessors - takes a specific job and the list of tasks then returns a
list of the immediate predecessors for that job.

    ```lisp
    (predecessors 'vapor_barrier_insulation tasks)
    ```

    should return

    ```lisp
    (roof install_windows_doors)
    ```

3. gettime - takes a job and the list of tasks then returns the time that job
takes

4. get_all_preds - takes a specific job and the list of tasks then returns a
list of all of the predecessors for that job

5. precedes - takes two specific jobs and the list of tasks then returns true
if the first job must precede the other and nil otherwise

6. start_day - takes a specific job and the list of tasks then returns the
day that this job can start

7. get_max - takes a list of job names and the list of tasks then returns a
list with the time and the job that finishes at the greatest time

    ```lisp
    (get_max '(frame roof select_subs) tasks)
    ```

    should return

    ```lisp
    (37 roof)	 ;since roof cannot finish until day 37
    ```

*Hint*: #6 & #7 can be written as mutually recursive.

8. critical_path - takes a job and the list of tasks then returns a list of the
jobs on the critical path to getting this job done in the least amount of time

9. depends_on - takes a job and the list of tasks then returns a list of the
jobs that cannot be started until this job has completed. This should return
all future jobs, not just the ones immediately affected.

## Data file:

The data file is
[here](http://rowdy.msudenver.edu/~gordona/cs3210/data/building.txt).

## Tests:

To run tests:

    ```bash
    make test
    ```

To run tests on utilities:

    ```bash
    make test-utils
    ```

Output from tests:

    ```
    Unit Test Summary
     | 24 assertions total
     | 24 passed
     | 0 failed
     | 0 execution errors
     | 0 missing tests
    ```
