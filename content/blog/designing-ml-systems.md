---
title: Designing Machine Learning Systems
date: 2022-07-13
---

[Chip Huyen](https://huyenchip.com) recently released an excellent book, [Designing Machine Learning Systems: An Iterative Process for Production-Ready Applications](https://www.amazon.com/Designing-Machine-Learning-Systems-Production-Ready/dp/1098107969). Recently I also read this book and recommend it wholeheartedly to anyone interested in the end-to-end machine learning lifecycle (go buy it now!). As I read through the book, I kept some notes of each chapter to improve my recall of the contents. I can't pretend that these notes cover all the topics addressed in the book, but here they are :)

## Chapter Notes

### 1. Overview of Machine Learning Systems

Machine learning solutions are appropriate when you want to (1) _learn_ (2) _complex patterns_ from (3) _existing data_ and use these patterns to make (4) _predictions_ on (5) _unseen data_. ML solutions are particularly effective when (6) the task is repetitive, (7) the cost of wrong predictions is cheap, and (8) it's at scale.

### 2. Introduction to Machine Learning Systems Design

Different teams often have different priorities, and it can be difficult to weigh competing metrics (it's much easier to optimize for a single metric). At the end of the day, profit is the primary driver, so it's critical to tie an ML system's performance to the overall business performance.

ML systems should meet four characteristics: _reliability_ (performing even in the face of faults), _scalability_ (efficiently adjusting to traffic volume), _maintainability_ (relevant software, data, and artifacts are high-quality, documented, tracked, and organized), and _adaptability_ (the system can respond to data and business changes without downtime)

In real life, developing these ML systems is very much an iterative process, where the interaction between steps is continuously reexamined:

1. Project scoping
1. Data engineering
1. ML model development
1. Deployment
1. Monitoring and continual learning
1. Business analysis

### 3. Data Engineering Fundamentals

Common data formats can be either text (human-readable) or binary, and row-major or column-major. In general, binary data is more performant and compact but cannot be directly inspected. _Row-major_ formats like CSV offer easy writes and appends; _column-major_ formats like Parquet offer great (column-based) read performance, especially useful for analytical workloads.

_Data models_ describe how data is represented. Two common models are relational and NoSQL (of which document and graph models are notable subtypes).

_Transaction processing_ must be done quickly and be highly available; on the other hand, _analytical processing_ can support higher latency and often aggregate across multiple data sources.

Data movement can take the form of data passing through databases, through services (request-driven and synchronous), and through real-time transport (event-driven, asynchronous, and communicate through brokers, e.g. pubsub and message queues).

### 4. Training Data

Data in the real world can be hard to collect and severely imbalanced, and _sampling_ and _data augmentation_ help to curate the right datasets to build ML on top of. _Natural labels_ are collected or created automatically by the system and are very useful for ML applications like recommender systems, although the labels may take a while to be created and stored.

### 5. Feature Engineering

Missing values can be of three types:

- _Missing not at random_ (MNAR) means the reason a value is missing is because of the true value itself. For example, some people may choose not to respond when asked their income because it is especially low or high.
- _Missing at random_ (MAR) means another observed variable influences the fact that the value is missing. For example, people of one gender may prefer to not disclose their age.
- _Missing completely at random_ (MCAR) means there is really no pattern to when the value is missing. This type is very rare. Deletion is most appropriate for this type of missing value as long as the number of affected rows is small.

_Data leakage_ is a particularly sneaky reason why ML applications fail in production. Pay careful attention to how you split time-correlated data; handle scaling, missing values, and duplicate values when splitting; and leakage that may come from the data generation process itself.

Continually revising the features included for a model is imperative for managing technical debt&mdash;too many features can result in overfitting, data leakage, increased latency/storage/memory, and unused features (aka tech debt). Use features that are important to the model and that generalize well, and remove features that are no longer useful even if they once were.

### 6. Model Development and Offline Evaluation

When deciding which model is a good fit for your application, consider:

- Data, compute, and training time requirements
- Inference latency
- Interpretability

Start with the simplest models and add complexity only when absolutely necessary! Consider that some models may perform worse now but be easier to update later (for example, a neural network that can continually learn vs a collaborative filtering model that cannot). Shifting from one model to an ensemble of models will probably be much harder to deploy, maintain, and debug, but the extra performance could potentially yield massive gains.

Tracking and versioning your experiments is very helpful for reproducibility, but can feel tedious&mdash;use tooling and infrastructure to ease the burden. Distributed training can make large models and training workloads feasible; AutoML can also help to tune parameters or test a massive number of different model architectures.

Having a good baseline to compare a challenger model against is essential for gauging relative performance&mdash;this point of reference could be random, a simple heuristic, the majority clas, human performance, or an existing (champion) model. For better robustness in production, employ perturbation, invariance, and directional expectation tests. Measure the model's calibration, confidence measurement, and performance on different slices.

### 7. Model Deployment and Prediction Service

ML engineers should expect to have to maintain many models, that those models' performance will degrade and will need frequent updating, and to eventually have to scale up.

Batch prediction uses only batch features, but online prediction can use any combination of batch and/or streaming features. Unifying batch and streaming pipelines goes a long way to ensuring consistency and preventing nasty bugs.

Models can be compressed through methods like _low-rank factorization_ (replacing high-dimensional tensors with low-dimensional ones), _knowledge distillation_ (a teacher model trains a smaller student model), _pruning_ (removing nodes or setting parameters to 0), and _quantization_ (reducing precision by using fewer bits to represent parameters).

Deploying models to the cloud is easier but more expensive; deploying to _edge devices_ is more hardware-constrained but provides less latency, better availability in poor connectivity areas, and more user privacy.

- Compiling and optimizing models for edge devices is challenging! _Intermediate representations (IRs)_ are a series of progressively lower-level representations that translate high-level (e.g., PyTorch) code into machine code. Optimization engineers are usually brought in to optimize models for a certain hardware, although ML is getting increasingly involved in this step.

### 8. Data Distribution Shifts and Monitoring

ML systems fail because of all the same reasons that software systems fail _and then some_: dependencies, deployment, hardware, etc. But differences in data between development and production, as well as new edge cases and degenerate feedback loops (where a system's outputs influence its future inputs), raise the bar further.

Common types of data distribution shifts are:

- _Covariate shift_, where the input distribution changes but the prediction model P(Y;X) does not change
- _Label shift_, where the output distribution changes but, for a given output, the input distribution stays the same. This is related to covariate shift and often shows up together.
- _Concept drift_, where the same input yields a different output. This is often cyclic or seasonal.

Monitoring ML systems can be useful at different points of the stack: from raw inputs to features to predictions to performance metrics. Raw inputs are harder to monitor than performance metrics but are less likely to be caused by human errors; on the other hand, performance metrics are closest to the business metrics that the system is there to help.

### 9. Continual Learning and Test in Production

#### Continual Learning

_Continual learning_ allows us to respond to data distribution changes by continually updating ML models. It represents a paradigm shift from the traditional approach of batch learning, but opens many doors to better performance. The "learning" in "continual learning" may be done statelessly (retraining models from scratch with newer data) or statefully (continuing the training of a previous model with newer data)&mdash;similar to transfer learning and fine-tuning, the latter requires much less data. Both of these are examples of _data iteration_, where the same model is refreshed with different data, as opposed to _model iteration_, where the features or architectures of a model are changed.

#### Testing in Production

Many problems encountered in machine learning model deployment are unique to a production environment; they cannot be (reasonably) recreated in a test environment. So there are some strategies to make the rollout of a new model safer and with higher confidence that it will improve the business metric for which it exists:

- _Shadow deployment_ involves deploying a challenger model in the background and logging its predictions to be analyzed later (while still returning predictions from the champion model). If the challenger's performance looks okay, it can then be promoted.
- _A/B testing_ randomly assigns groups of users to interact with models. Commonly, two models A and B are compared with each other, but the experiment may be set up for more than one treatment (i.e., A/B/C/D testing). Since this is a statistical experiment, it's important to ensure that user assignment is completely random, that there are no confounding variables (like which type of device users are on), and that groups and predictions are isolated from one another.
- _Canary release_ or _canary deployment_ rolls out the challenger model to a small subset of users, devices, etc. If the performance meets or exceeds that of the champion model, its rollout progresses; if the performance plummets, its rollout is immediately rolled back and the champion model remains in effect.
- _Interleaved experiments_ display predictions from both models side-by-side and is used especially in the context of recommender systems. Deciding if model A or model B is better becomes much easier when recommendations from both models are displayed and the user can act on their preferred item. However, the information provided relates mostly to users' preferences, not **XYZ**.
- _Bandits_ are the most data-efficient option, but also the most complex to implement&mdash;for this reason, their use is most common in large tech companies.

### 10. Infrastructure and Tooling for MLOps

The infrastructure used for powering machine learning at scale can be split into four layers:

1. _Storage and compute_ allow for collection and storage of data, and provide the resources necessary to run ML and other workloads
1. _Resource management_ schedules and orchestrates workloads to make better use of your compute resources
1. _ML platform_ provides ML-specific tooling to help with development and deployment of ML applications, like model registries, feature stores, and monitoring tools
1. _Development environments_ are where code is written and experiments are run

#### Storage and Compute

Data storage can be handled in a variety of ways, but it's so cheap now that many companies default to storing everything in the cloud. This topic is covered mostly in the previous chapters.

Compute may be ephemeral (think serverless like AWS Step Functions or Google Cloud Run) or more long-lived (like EC2).

#### Resource Management

Schedulers deal with _when_ jobs run while orchestrators deal with _where_ jobs run, but there is often some overlap between frameworks. Workflow management tools are similar to schedulers, but deal more with tasks and workflows as a whole rather than individual jobs (think high-level vs. low-level).

Cron is a simple job scheduler. More complex solutions like Airflow can handle dependencies between jobs as well as resource management.

- Airflow
- Prefect
- Argo
- Kubeflow
- Metaflow

#### ML Platform

- _Model deployment_ services should make it easy for you to offer online and batch predictions (with batch predictions being a better indicator of quality, as it involves the nuances of job scheduling and prediction storage) as well as performing different test-in-production schemes described in chapter 9
- _Model stores_ help track ML artifacts like: model definitions and parameters, software and data dependencies, model generation code, other experiment artifacts, and metadata tags (like model owners or the relevant business task). Even [MLflow](https://mlflow.org), the most popular model store, still is far from solving the artifact problem.
- _Feature stores_ help address feature management (sharing, discovering, and describing features), transformation (performing computation and storing the results for reuse), and/or consistency (ensure aligment between features for dev/production environments, batch/streaming pipelines, and training/inference).

#### Development Environments

Dev environments are where data scientists and engineers spend most of their time. Improvements you make here can vastly improve the productivity for many users. Progressing down the dependency spectrum of standardized packages to standardized Python/language versions to standardized dev containers to cloud-based development environments can greatly improve the consistency and experience across teams as well as reduce the burden of supporting many different IDEs and environment configurations.

### 11. The Human Side of Machine Learning

It can be common to have a separate team managing production and deployments, but this often yields worse communication/collaboration and more difficult debugging (worse visibility). Having end-to-end data scientists is harder to recruit and train for, but can have great impact.
