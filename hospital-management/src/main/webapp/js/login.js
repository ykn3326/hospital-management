/**
 * Hospital Management System - Enhanced UI Interactions
 * Handles: password toggle, role hints, form validation, animations
 */

document.addEventListener('DOMContentLoaded', function () {

    // =============================================
    // 1. PASSWORD TOGGLE
    // =============================================
    const toggleButtons = document.querySelectorAll('.toggle-password');
    toggleButtons.forEach(btn => {
        btn.addEventListener('click', function () {
            const inputGroup = this.closest('.password-input-group');
            if (!inputGroup) return;
            const passwordInput = inputGroup.querySelector('input[type="password"], input[type="text"]');
            if (!passwordInput) return;

            const isHidden = passwordInput.type === 'password';
            passwordInput.type = isHidden ? 'text' : 'password';
            this.innerHTML = isHidden
                ? '<i class="fas fa-eye-slash"></i>'
                : '<i class="fas fa-eye"></i>';
            passwordInput.focus();
        });
    });

    // =============================================
    // 2. ROLE HINT SYSTEM (Login Page)
    // =============================================
    const roleSelect = document.querySelector('[name="role"]');
    const roleHint = document.querySelector('.role-hint');

    if (roleSelect && roleHint) {
        const hints = {
            patient: 'Use your patient email to track appointments, medical records and billing.',
            doctor: 'Login to manage your appointments, patient notes and prescriptions.',
            admin: 'Admin access gives you control over operations, staff and system settings.'
        };

        const icons = {
            patient: 'fa-user-injured',
            doctor: 'fa-user-md',
            admin: 'fa-user-shield'
        };

        function updateRoleHint() {
            const role = roleSelect.value;
            const hintText = hints[role] || 'Select your account type to continue.';
            const icon = icons[role] || 'fa-info-circle';

            roleHint.innerHTML = '<i class="fas ' + icon + '"></i> <span>' + hintText + '</span>';

            // Animate
            roleHint.style.animation = 'none';
            requestAnimationFrame(() => {
                roleHint.style.animation = 'slideDown 0.3s ease';
            });
        }

        roleSelect.addEventListener('change', updateRoleHint);
        updateRoleHint();
    }

    // =============================================
    // 3. FORM VALIDATION
    // =============================================
    const forms = document.querySelectorAll('form');
    forms.forEach(form => {
        form.addEventListener('submit', function (e) {
            const submitBtn = this.querySelector('button[type="submit"]');
            const requiredFields = this.querySelectorAll('[required]');
            let isValid = true;

            requiredFields.forEach(field => {
                // Clear previous error state
                field.classList.remove('error', 'success');

                if (!field.value.trim()) {
                    field.classList.add('error');
                    isValid = false;
                    showFieldError(field, 'This field is required');
                } else if (field.type === 'email' && !isValidEmail(field.value)) {
                    field.classList.add('error');
                    isValid = false;
                    showFieldError(field, 'Please enter a valid email address');
                } else if (field.name === 'password' && field.value.length < 6) {
                    field.classList.add('error');
                    isValid = false;
                    showFieldError(field, 'Password must be at least 6 characters');
                } else {
                    field.classList.add('success');
                }

                // Real-time validation on input
                field.addEventListener('input', function () {
                    if (this.value.trim()) {
                        this.classList.remove('error');
                        this.classList.add('success');
                        removeFieldError(this);
                    } else {
                        this.classList.remove('success');
                    }
                }, { once: false });
            });

            if (!isValid) {
                e.preventDefault();
                // Focus first error field
                const firstError = this.querySelector('.error');
                if (firstError) firstError.focus();
                return;
            }

            // Show loading state on button
            if (submitBtn) {
                const originalText = submitBtn.innerHTML;
                submitBtn.disabled = true;
                submitBtn.innerHTML = '<span class="spinner"></span> Processing...';
                // Re-enable after timeout (safety net)
                setTimeout(() => {
                    submitBtn.disabled = false;
                    submitBtn.innerHTML = originalText;
                }, 10000);
            }
        });
    });

    // =============================================
    // 4. FIELD ERROR HELPERS
    // =============================================
    function showFieldError(field, message) {
        // Remove existing error for this field
        removeFieldError(field);

        const errorEl = document.createElement('div');
        errorEl.className = 'field-error';
        errorEl.style.cssText = 'color: var(--danger); font-size: 0.8rem; margin-top: 4px; display: flex; align-items: center; gap: 4px;';
        errorEl.innerHTML = '<i class="fas fa-exclamation-circle"></i> ' + message;
        field.parentNode.insertBefore(errorEl, field.nextSibling);
    }

    function removeFieldError(field) {
        const existing = field.parentNode.querySelector('.field-error');
        if (existing) existing.remove();
    }

    function isValidEmail(email) {
        return /^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email);
    }

    // =============================================
    // 5. TOAST NOTIFICATION SYSTEM
    // =============================================
    // Create toast container if it doesn't exist
    if (!document.querySelector('.toast-container')) {
        const toastContainer = document.createElement('div');
        toastContainer.className = 'toast-container';
        document.body.appendChild(toastContainer);
    }

    window.showToast = function (message, type) {
        const container = document.querySelector('.toast-container');
        const toast = document.createElement('div');
        toast.className = 'toast toast-' + (type || 'info');

        const icons = {
            success: 'fa-check-circle',
            error: 'fa-exclamation-circle',
            info: 'fa-info-circle'
        };

        toast.innerHTML = '<i class="fas ' + (icons[type] || icons.info) + '"></i> ' + message;
        container.appendChild(toast);

        // Remove after animation
        setTimeout(() => {
            if (toast.parentNode) {
                toast.remove();
            }
        }, 4000);
    };

    // =============================================
    // 6. SMOOTH SCROLL FOR ANCHOR LINKS
    // =============================================
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            const targetId = this.getAttribute('href');
            if (targetId === '#') return;
            const target = document.querySelector(targetId);
            if (target) {
                e.preventDefault();
                target.scrollIntoView({ behavior: 'smooth', block: 'start' });
            }
        });
    });

    // =============================================
    // 7. NAVBAR SCROLL EFFECT
    // =============================================
    const navbar = document.getElementById('navbar');
    if (navbar) {
        window.addEventListener('scroll', function () {
            if (window.scrollY > 10) {
                navbar.classList.add('scrolled');
            } else {
                navbar.classList.remove('scrolled');
            }
        });
    }

    // =============================================
    // 8. CONSOLE WELCOME
    // =============================================
    console.log('%c Hospital Management System v2.0 ', 'background: #1a73e8; color: white; font-size: 14px; font-weight: bold; padding: 8px 12px; border-radius: 4px;');
    console.log('%c Built with ❤️ for modern healthcare ', 'color: #64748b; font-size: 12px;');
});
