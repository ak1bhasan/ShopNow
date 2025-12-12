// Custom JavaScript for E-Commerce Platform

document.addEventListener("DOMContentLoaded", function () {
  // Auto-dismiss alerts after 5 seconds
  const alerts = document.querySelectorAll(".alert");
  alerts.forEach(function (alert) {
    setTimeout(function () {
      const bsAlert = new bootstrap.Alert(alert);
      bsAlert.close();
    }, 5000);
  });

  // Confirm delete actions
  const deleteForms = document.querySelectorAll('form[action*="delete"]');
  deleteForms.forEach(function (form) {
    form.addEventListener("submit", function (e) {
      if (!confirm("Are you sure you want to delete this item?")) {
        e.preventDefault();
      }
    });
  });

  // Quantity input validation
  const quantityInputs = document.querySelectorAll('input[name="quantity"]');
  quantityInputs.forEach(function (input) {
    input.addEventListener("change", function () {
      const max = parseInt(this.getAttribute("max"));
      const min = parseInt(this.getAttribute("min"));
      const value = parseInt(this.value);

      if (value > max) {
        this.value = max;
        alert("Maximum quantity exceeded. Set to " + max);
      }
      if (value < min) {
        this.value = min;
      }
    });
  });

  // Handle logout link - simple and direct approach
  document.addEventListener('click', function(e) {
    const logoutLink = e.target.closest('#logout-link');
    if (logoutLink) {
      e.preventDefault();
      e.stopPropagation();
      e.stopImmediatePropagation();
      const logoutUrl = logoutLink.getAttribute('href');
      console.log('Logout triggered, navigating to:', logoutUrl);
      window.location.href = logoutUrl;
      return false;
    }
  }, true); // Use capture phase to catch before Bootstrap

  // Safety: ensure modals are visible and page is not blurred
  const addProductModalEl = document.getElementById('addProductModal');

  const clearPageBlur = () => {
    document.body.classList.remove('blur', 'page-blur', 'freeze', 'overlay');
    document.body.style.filter = '';
    document.body.style.backdropFilter = '';
    document.body.style.webkitBackdropFilter = '';
    document.body.style.opacity = '';
    document.body.style.pointerEvents = '';

    const blurSelectors = [
      '.content',
      '.content-wrapper',
      '.page-wrapper',
      '.container',
      '.container-fluid'
    ];

    blurSelectors.forEach(sel => {
      document.querySelectorAll(sel).forEach(el => {
        el.classList.remove('blur', 'page-blur', 'freeze', 'overlay');
        el.style.filter = '';
        el.style.backdropFilter = '';
        el.style.webkitBackdropFilter = '';
        el.style.opacity = '';
        el.style.pointerEvents = '';
      });
    });

    // remove any custom overlays that might sit above the modal
    const overlaySelectors = [
      '.overlay',
      '.blur-overlay',
      '.glass-overlay',
      '.screen-overlay',
      '.page-dim',
      '.modal-bg',
      '.popup-shadow'
    ];
    overlaySelectors.forEach(sel => {
      document.querySelectorAll(sel).forEach(el => el.remove());
    });

    // ensure body is not stuck in modal-open lock state
    document.body.classList.remove('modal-open');
    document.body.style.overflow = '';
    document.body.style.paddingRight = '';
  };

  if (addProductModalEl) {
    // ensure modal is attached to body to avoid parent stacking/transform issues
    if (addProductModalEl.parentElement !== document.body) {
      document.body.appendChild(addProductModalEl);
    }

    addProductModalEl.addEventListener('show.bs.modal', () => {
      clearPageBlur();
      // ensure stacking context consistent with Bootstrap defaults
      addProductModalEl.style.zIndex = '1050';
      addProductModalEl.style.pointerEvents = 'auto';
    });
    addProductModalEl.addEventListener('shown.bs.modal', () => {
      clearPageBlur();
      const backdrop = document.querySelector('.modal-backdrop');
      if (backdrop) {
        backdrop.style.zIndex = '1040';
        backdrop.style.pointerEvents = 'auto';
        backdrop.classList.add('show');
      }
      addProductModalEl.style.pointerEvents = 'auto';

      // remove duplicate backdrops if any were left behind
      const backdrops = document.querySelectorAll('.modal-backdrop');
      if (backdrops.length > 1) {
        backdrops.forEach((bd, idx) => {
          if (idx > 0) bd.remove();
        });
      }
    });
    addProductModalEl.addEventListener('hidden.bs.modal', () => {
      clearPageBlur();
      addProductModalEl.style.pointerEvents = 'auto';
    });
  }
});
