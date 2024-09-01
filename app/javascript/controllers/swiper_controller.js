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

export default class extends Controller {
  connect() {
    this.initializeSwiper();
  }

  initializeSwiper() {
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
          this.showMatchNotification();
        }
      } else {
        console.error('Error recording swipe:', data.errors);
        this.showErrorNotification(data.errors);
      }
    })
    .catch(error => {
      console.error('Error:', error);
      this.showErrorNotification(['An unexpected error occurred']);
    });
  }

  showMatchNotification() {
    // カスタムのマッチ通知を実装
    alert('You have a new match!'); // これは仮の実装です。より洗練された通知方法に置き換えることができます。
  }

  showErrorNotification(errors) {
    // エラー通知を実装
    alert(`Error: ${errors.join(', ')}`); // これは仮の実装です。より洗練された通知方法に置き換えることができます。
  }

  disconnect() {
    if (this.swiper) {
      this.swiper.destroy();
    }
  }
}