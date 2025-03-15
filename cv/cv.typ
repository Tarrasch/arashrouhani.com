#import "@preview/silver-dev-cv:1.0.2": cv, section, descript, sectionsep, job
#set list(
  indent: 1em,
  spacing: 0.8em,
)
#set par(
  spacing: 1.25em,
  justify: true,
)

#let watermark = if true {
  rotate(24deg, text(105pt, fill: red.transparentize(85%))[DO NOT SUBMIT])
} else {
  none
}
#set page(
  foreground: watermark
)

#show: cv.with(
  font-type: "New Computer Modern",
  continue-header: "false",
  name: "Arash Rouhani",
  address: "Zürich, Switzerland",
  lastupdated: "true",
  pagecount: "true",
  date: "2025-02-21",
  contacts: (
    (text: "LinkedIn", link: "https://www.linkedin.com/in/arash-rouhani-93193463/"),
    (text: "Github", link: "https://www.github.com/tarrasch"),
    (text: "arash.rouhani@gmail.com", link: "mailto:arash.rouhani@gmail.com"),
    (text: "arashrouhani.com", link: "https://www.arashrouhani.com"),
  ),
)

// about
#section[About Me]
#descript[I'm a developer at YouTube (Google) building viewer-facing features using RPC-based C++ technologies.]

#section("Technologies")
 - Written *C++* for 7+ years at Google.
 - Used *Python* professionally and done major open source contributions (see Luigi).
 - Functional Programming: Used *Haskell* in #link("https://github.com/search?l=Haskell&q=%40Tarrasch&type=Repositories")[open source projects]

#sectionsep
#section("Work experience summary")
_See detailed descriptions on page 2._

#job(
  position: "Senior Software Engineer",
  institution: [Google],
  location: "Zürich",
  date: "2017-ongoing",
  description: [
    - Feature development at Google scale and mentoring around 5-10 engineers.
    - Learned the technical design that powers much of YouTube.
  ],
)

#job(
  position: "Software Engineer in R&D",
  institution: [VNG Corporation],
  location: "HCMC, Vietnam",
  date: "2015-2017",
  description: [
    - NLP, writing data pipelines and guiding the big data architecture.
  ],
)

#job(
  position: "Big Data Engineer",
  institution: [Spotify],
  location: "Stockholm, Sweden",
  date: "2014-2015",
  description: [
    - Data platform development and supporting our Luigi and Apache Crunch users.
  ],
)

In addition to full time employments. I've had 5 tech internships, including at *Meta* and *Spotify*.

#sectionsep
#section("Professional Qualifications")
  - Previously chief maintainer of #link("https://github.com/spotify/luigi")[Luigi], a
     popular open source task orchestrator.
  - Second best Swedish participant in Google Code Jam 2010 and TopCoder Open 2010.
  - Won the Swedish national Informatics Olympiad in 2009. Participated in IOI 2009 in Bulgaria.
  - I use Linux and git/Mercurial on a daily basis and I have written many #link("https://github.com/search?q=\%40Tarrasch+zsh+OR+antigen\&type=Repositories\&ref=searchresults")[zsh shell plugins].
  - Graduate thesis on the Haskell compiler (#link("https://www.arashrouhani.com/papers.html")[description], #link("https://www.arashrouhani.com/papers/master-thesis.pdf")[pdf]).

#sectionsep
#section("Education")
 - Master’s degree in Algorithms, Languages and Logic from Chalmers (August 2009 to April 2014)
 - Graduate level exchange studies at Georgia Tech (August 2012 to May 2013)
 - GPA of 4.67/5.00 and 3.87/4.00 respectively. More info on my website.

#sectionsep
#section("Other merits")
 - Organizing the #link("http://progolymp.se/")[informatics contest in Sweden].
   I've authored about
   30 tasks (with solutions and input data) and traveled to Estonia (2010),
   Denmark (2011), Latvia (2012), Taiwan (2014), Kazakhstan (2015) and Norway (2017) as a
   team leader with the Swedish IOI team.

#pagebreak()

#set document(author: "tarrasch", title: "Arash Rouhani's CV")

_Still curious? This page goes into more detail about my professional experience_.

#section("Work experience")

#job(
  position: "Senior Software Engineer",
  institution: [Google],
  location: "Zürich",
  date: "2017-ongoing",
  description: [
    - Developed and launched key features for a popular YouTube monetization product, impacting hundreds of millions of users and generating millions in annual revenue.
    - Worked on many of the big YouTube system like LiveChat, Comments and Creator Studio.
    - Created new C++ servers, services and handlers and interfaced with many of YouTube's serving systems.
    - Automated testing: Unit tests, handler tests, screenshot tests, verified mocks and end-to-end tests.
    - Worked with ML models that predicts our user success metrics.
    - Been the go-to person for A/B testing. I've improved many of my peers experiment designs to become measurable. Often saving weeks of experimentation time.
    - Conducted 70+ technical and leadership interviews.
    - Utilizing Google's AI-based code generation tools to reduce development time.
    - Development on Android, iOS and Web clients where existing client capabilities were lacking.

    // - Developed and launched key features for #link("https://www.youtube.com/intl/en_us/join/")[a popular YouTube monetization product]. Features that are seen by hundreds of millions of users and are contributing to millions in yearly added revenue.
    // - I'm working on a popular YouTube #link("https://www.youtube.com/intl/en_us/join/")[monetization feature] as a full stack software engineer.
    // - Worked with ML models that predicts the success of our users (YouTube Channels).
    // - Lead and launched multiple projects implementing new user-facing features, on multiple platforms (Web, Mobile) across multiple product surfaces (LiveChat, Comments, Creator Studio) implemented mainly using C++. Leading a project involves design, getting buy-in, implementing, experimenting, analyzing, collaborating across the organization and leading other engineers in the team. The added functionalities are generating millions in revenue and have become indispensable to our users.
    //   - I've set up new servers, services and handlers running in C++.
    //   - Defined new datatypes in multiple different storage systems with different capabilities. Including systems needing to serve data with millions of QPS.
    //   - Written client-side code when necessary.
    //   -
    // - Experimentation expert. I've improved many of my peers experiment designs to become measurable. This typically saves many weeks of the experimentation time per experiment.
    // - Interviewed 70+ candidates.
    // - Utilized Google's AI-based code generation tools to greatly reduce development time.
  ],
)

#job(
  position: "Software Engineer in R&D",
  institution: [VNG Corporation],
  location: "HCMC, Vietnam",
  date: "2015-2017",
  description: [
    - Comprehensive NLP on Vietnamese news articles - from word tokenization to topic modeling.
    - Data analysis using Jupyter and Pandas.
    - Guided the big data architecture on a high level while also solving low level issues #link("http://luigi.readthedocs.io/en/stable/luigi_patterns.html#atomic-writes-problem")[(example)].
    - Greatly inspired the whole team to write better code.
  ],
)

#job(
  position: "Big Data Engineer",
  institution: [Spotify],
  location: "Stockholm, Sweden",
  date: "2014-2015",
  description: [
    - Developed data engineering tools and provided expert consultation for the company's Big Data users.
    - Spearheaded the adoption of Luigi for workflow orchestration and Apache Crunch for ETL.
    - Contributed to substantial improvements in Luigi's code quality and performance, leading to my appointment as Chief Maintainer.
  ],
)

#job(
    position: "Big Data Tech Intern",
    institution: [Meta],
    location: "Menlo Park, CA, USA",
    date: "Summer 2013",
    description: [
        - Worked on an internal job scheduler written in Python, integrating with HBase to manage dynamic region mappings using reactive programming.
        - Replaced a MapReduce job with a solution leveraging said internal scheduler, achieving a 2x performance improvement.
    ],
)

#if watermark != none [
  _To see my CV without a watermark, please reach out to me over email! _
]
