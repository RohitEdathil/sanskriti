# Kala (Technical Documentation)

A new simple booking platform for performing arts

## Technology Stack

Why did I choose these technologies?

- [Flutter](https://flutter.dev/) : Fast to run an make app out of, just gorgeous
- [Firebase](https://firebase.google.com/) : Simple and easy to use, and free

## Design

To account for the strict deadlines, no code refactoring was done (So beware if you decide to look through the code). There are some comments though :)

## User Flows

### Booking

- Users login to the app
- They enter the explore view
- Choose a culture
- Choose an artform
- Choose an artist
- Choose a program type
- Send a request to the artist with (date, location and optional message)

### Artist

- Login to the app
- Either Accept or Reject the request

### Sample Database structure

The database is Firebase Realtime Database. The structure is as follows:

```json
{
  "cultures": [
    {
      "arts": [
        {
          "artists": [
            "L4M0L827tmTgtGPF7AsyvnK9LhD2",
            "PP2gxnUZSnPtruOn3U6wpzpA5ds1"
          ],
          "desc": "A \"Chenda Melam\" means percussion using Chenda. The Chenda is used as a percussion instrument for almost all Kerala art forms like Kathakali, Kodiyattam, Theyyam etc. Chenda melam is the most popular form in Kerala, for more than 300 years. A Chenda melam is an integral part of all festivals in Kerala.",
          "image": "https://i.pinimg.com/originals/83/15/17/831517686f16ccc58c5430a8ca6a4ac0.jpg",
          "name": "Chenda Melam",
          "video": "xOcmz79tVhs"
        },
        {
          "desc": "Theyyam is the popular ritual art form of Kolathunadu (Kingdom of Cannanore). The Theyyam dance is performed in front of the village shrine, groves, and in the houses as ancestor worship. The theyyam period is from the 10th of Malayalam month Thulam (October/November) and comes to a close by the end of June.",
          "image": "https://i.ytimg.com/vi/vhyjoWfl0Pw/maxresdefault.jpg",
          "name": "Theyyam",
          "video": "BeczZlAnnQM"
        },
        {
          "desc": "Famous around the world, Kathakali's magnificence has won great admiration for the state of Kerala. Proud that this renowned artfrom originated, was originated from Kerala’s shores over 300 years ago. It combines devotion, drama, dance, music, costumes and make up into a divine experience for all who get to view it.",
          "image": "https://www.withmanish.com/wp-content/uploads/2017/11/Kathakali-Face-Expression4.jpg",
          "name": "Kathakali",
          "video": "nwiLwsgicno"
        }
      ],
      "desc": "Kerala, a state on India's tropical Malabar Coast, has nearly 600km of Arabian Sea shoreline. It's known for its palm-lined beaches and backwaters, a network of canals. Inland are the Western Ghats, mountains whose slopes support tea, coffee and spice plantations as well as wildlife.",
      "image": "https://img.onmanorama.com/content/dam/mm/en/travel/travel-news/images/2022/7/13/kerala-tourism.jpg",
      "name": "Kerala",
      "video": "s3mCVDcYZV4"
    },
    {
      "desc": "Maharashtra is a state in the western peninsular region of India occupying a substantial portion of the Deccan Plateau. Maharashtra is the second-most populous state in India and the second-most populous country subdivision globally.",
      "image": "https://cdn.businesstraveller.com/wp-content/uploads/fly-images/427441/gateway-of-india-mumbai-e1467296338811-916x515.jpg",
      "name": "Maharashtra",
      "video": "mrpY-BriICM"
    }
  ],
  "requests": {
    "-NLEG3xXtP1tbrP0jjXu": {
      "artistId": "L4M0L827tmTgtGPF7AsyvnK9LhD2",
      "date": 1673634600000,
      "location": "Manjoor South ",
      "programName": "At temples",
      "remark": "What about travel arrangements? ",
      "status": 1,
      "userId": "bfsenYOy2Og3GvOnetxrHI4NbHi2"
    }
  },
  "users": {
    "L4M0L827tmTgtGPF7AsyvnK9LhD2": {
      "contact": 9876543210,
      "desc": "Peruvanam Kuttan Marar is a chenda artist. He leads several popular traditional orchestra performances in Kerala. He is a recipient of Padma Shri award in the year 2011 for his contributions in the field of art.[1]",
      "image": "https://firebasestorage.googleapis.com/v0/b/sanskriti-iedc.appspot.com/o/marar.jpg?alt=media&token=54cd12b6-5339-4eef-83f9-52b7d3861e4d",
      "is_artist": true,
      "name": "Peruvanam Kuttan Marar",
      "programs": {
        "At temples": {
          "desc": "Melam events strictly at a temple. ",
          "rate": 100000,
          "time": "5 Hours"
        },
        "Private events": {
          "desc": "Melams at other events",
          "rate": 120000,
          "time": "3 Hours"
        }
      }
    },
    "PP2gxnUZSnPtruOn3U6wpzpA5ds1": {
      "contact": 9876543210,
      "desc": "Thrissur Based Shinkari Music and Chenda Percussion Band.  Aattam Kalasamithi Kollanur is known for its innovative, uniqueness and energetic performances.",
      "image": "https://firebasestorage.googleapis.com/v0/b/sanskriti-iedc.appspot.com/o/aattam.jpg?alt=media&token=2e8459a9-e1c7-434e-9640-35982c850134",
      "is_artist": true,
      "name": "Aattam Kalasamithi",
      "programs": {
        "Schools & Colleges": {
          "desc": "Vibrant dance with a lot of color , exclusively for events at educational institutions",
          "rate": 50000,
          "time": "10 Hours"
        }
      }
    },
    "bfsenYOy2Og3GvOnetxrHI4NbHi2": {
      "is_artist": false
    }
  }
}
```

## Security Policy

TBD
