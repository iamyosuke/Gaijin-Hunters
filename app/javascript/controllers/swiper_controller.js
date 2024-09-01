// cdnから取るようにするためコメントアウト
// import { Controller } from "@hotwired/stimulus"
// import Swiper from "swiper"

// export default class extends Controller {
//   connect() {  console.log('Swiperコントローラーが接続されました。');

//     this.swiper = new Swiper(this.element, {
      
//       effect: "cards",
//       grabCursor: true,
//       navigation: {
//         nextEl: ".swiper-button-next",
//         prevEl: ".swiper-button-prev",
//       },
//     })

//     this.swiper.on('slideNextTransitionStart', () => this.handleSwipe('right'))
//     this.swiper.on('slidePrevTransitionStart', () => this.handleSwipe('left'))
//   }

//   handleSwipe(direction) {
//     const currentSlide = this.swiper.slides[this.swiper.activeIndex]
//     const userId = currentSlide.dataset.userId

//     fetch('/swipes', {
//       method: 'POST',
//       headers: {
//         'Content-Type': 'application/json',
//         'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
//       },
//       body: JSON.stringify({
//         swipe: {
//           swiped_user_id: userId,
//           direction: direction
//         }
//       })
//     })
//     .then(response => response.json())
//     .then(data => {
//       if (data.status === 'success') {
//         console.log('Swipe recorded successfully')
//         if (data.match) {
//           alert('You have a new match!')
//         }
//       } else {
//         console.error('Error recording swipe:', data.errors)
//       }
//     })
//     .catch(error => console.error('Error:', error))
//   }

//   disconnect() {
//     if (this.swiper) {
//       this.swiper.destroy()
//     }
//   }
// }
import { Controller } from "@hotwired/stimulus";

// Swiperをグローバル変数から使用
export default class extends Controller {
  connect() {
    this.swiper = new Swiper(this.element, {
      effect: "cards",
      grabCursor: true,
      navigation: {
        nextEl: ".swiper-button-next",
        prevEl: ".swiper-button-prev",
      },
    });

    this.swiper.on('slideNextTransitionStart', () => this.handleSwipe('right'));
    this.swiper.on('slidePrevTransitionStart', () => this.handleSwipe('left'));
  }

  handleSwipe(direction) {
    const currentSlide = this.swiper.slides[this.swiper.activeIndex];
    const userId = currentSlide.dataset.userId;

    fetch('/swipes', {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
      },
      body: JSON.stringify({
        swipe: {
          swiped_user_id: userId,
          direction: direction
        }
      })
    })
    .then(response => response.json())
    .then(data => {
      if (data.status === 'success') {
        console.log('Swipe recorded successfully');
        if (data.match) {
          alert('You have a new match!');
        }
      } else {
        console.error('Error recording swipe:', data.errors);
      }
    })
    .catch(error => console.error('Error:', error));
  }

  disconnect() {
    if (this.swiper) {
      this.swiper.destroy();
    }
  }
}
